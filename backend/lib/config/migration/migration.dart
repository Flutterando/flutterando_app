import 'dart:io';

import 'package:backend/config/postgres/query_adapter.dart';
import 'package:postgres/postgres.dart';

class Migration {
  final Pool connection;
  final String migrationPath;
  Migration({required this.connection, required this.migrationPath});

  Future<void> start() async {
    try {
      final migrationInDB = await connection.execute(
        'select migration_file from sys_migration',
      );

      List<String> migrationFile =
          migrationInDB.map((rows) => rows.first as String).toList();
      await _executeMigration(migrationFile);
    } on PgException catch (e) {
      if (e.toString().contains('relation "sys_migration" does not exist')) {
        await _executeMigration();
      } else {
        print(e.message);
      }
    } catch (e) {
      print('Migration error: $e');
    }
  }

  Future<void> _executeMigration([List<String> migrationIds = const []]) async {
    List<FileSystemEntity> migrationsToRun = _getMigrationFiles()
        .where(
          (file) => !migrationIds.contains(
            file.path.split(Platform.pathSeparator).last,
          ),
        )
        .toList();

    if (migrationsToRun.isEmpty) return;

    print('Start migration');
    for (var migration in migrationsToRun) {
      await _runMigration(migration);
    }
    print('End migration');
  }

  List<FileSystemEntity> _getMigrationFiles() {
    final Directory dir = Directory(migrationPath);
    List<FileSystemEntity> sysVideosPathList = dir.listSync(
      recursive: true,
      followLinks: false,
    );
    sysVideosPathList.sort((a, b) => a.path.compareTo(b.path));
    return sysVideosPathList;
  }

  Future<void> _runMigration(FileSystemEntity file) async {
    print('Migration running: ${file.path}');
    Map<String, dynamic> readMigration = _readMigration(file);
    try {
      await connection.runTx((session) async {
        List<String> querysList = readMigration['querys'] ?? [];
        for (var query in querysList) {
          await session.execute(query);
        }

        final insertMap = {
          'migration_file': readMigration['file'],
          'migration_content': readMigration['title'],
          'migration_description': readMigration['description']
        };

        await session.execute(insertMap.insertQuery('sys_migration'));
      });
    } catch (e) {
      print('Migration ${file.path} error: $e');
    }
    print('Migration done: ${file.path}');
  }

  Map<String, dynamic> _readMigration(FileSystemEntity file) {
    Map<String, dynamic> migrationMap = {
      'file': file.path.split(Platform.pathSeparator).last,
    };
    String migrationText = (file as File).readAsStringSync();

    List querysRows = [];
    for (var line in migrationText.split('\n')) {
      if (!line.contains('--') && line.isNotEmpty) {
        querysRows.add(line);
      }
      if (line.contains('--') && line.contains('TITLE:')) {
        migrationMap['title'] = line.split('TITLE:').last;
      }
      if (line.contains('--') && line.contains('DESCRIPTION:')) {
        migrationMap['description'] = line.split('DESCRIPTION:').last;
      }
    }
    migrationText = querysRows.join();
    migrationMap['querys'] = migrationText.split('-@@-');

    return migrationMap;
  }
}
