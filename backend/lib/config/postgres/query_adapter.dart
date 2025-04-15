import 'package:vaden/vaden.dart';

extension QueryAdapter on Map<String, dynamic> {
  String selectWhereQuery(String tableName) {
    late Map<String, dynamic> map = this;
    String query = 'select * from $tableName';

    return query + map.whereQuery();
  }

  String insertQuery(String tableName) {
    late Map<String, dynamic> map = this;
    map.removeWhere((key, value) => value == null);
    final String colunsNames = map.keys.toList().join(',');
    final String colunsData =
        map.values.map((value) => _valueType(value)).toList().join(',');

    return 'insert into $tableName ($colunsNames) values ($colunsData) RETURNING *';
  }

  String updateQuery(String tableName,
      {List<String> whereKeys = const ['id']}) {
    late Map<String, dynamic> map = this;
    map.removeWhere((key, value) => value == null);
    final whereMap = Map.fromEntries(
        map.entries.where((value) => whereKeys.contains(value.key)));
    if (whereMap.isEmpty) {
      throw ResponseException.badRequest('Update need a key');
    }
    map.removeWhere((k, v) => whereKeys.contains(k));

    if (map.isEmpty) {
      throw ResponseException.notModified(
          'There are no values to be modified modify');
    }

    return 'update $tableName ${map.setQuery()} ${whereMap.whereQuery()}  RETURNING *';
  }

  String whereQuery() {
    late Map<String, dynamic> map = this;

    if (map.isNotEmpty) {
      List<String> whereList = [];
      for (var where in map.entries) {
        if (where.value != null && where.value is List) {
          whereList.add(
              '${where.key} @> \'{${where.value.map((value) => _valueType(value)).toList().join(',')}}\'');
        } else if (where.value != null && where.value is! List) {
          whereList.add('${where.key} = ${_valueType(where.value)}');
        }
      }

      return whereList.isNotEmpty ? ' where ${whereList.join(' and ')}' : '';
    }

    return '';
  }

  String setQuery() {
    late Map<String, dynamic> mapPont = this;
    late Map<String, dynamic> map = {};
    map.addAll(mapPont);
    if (map.isNotEmpty) {
      List<String> whereList = [];
      for (var where in map.entries) {
        whereList.add('${where.key} = ${_valueType(where.value)}');
      }

      return whereList.isNotEmpty ? ' set ${whereList.join(', ')}' : '';
    }

    return '';
  }

  String _valueType(dynamic value) {
    var newValue = value;
    if (value is List<String>) {
      final listST = value.map((element) => '"$element"').join(', ');
      newValue = '{$listST}';
    }

    return switch (newValue) {
      (String val) => '\'$val\'',
      _ => '$newValue',
    };
  }
}
