import 'package:backend/vaden_application.dart';

void main() async {
  final vaden = VadenApplication();
  await vaden.setup();
  final server = await vaden.run();
  print('Server listening on port ${server.port}');
}

