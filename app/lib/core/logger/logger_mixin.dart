import 'logger.dart';

mixin LoggerMixin {
  Log get log => Log(runtimeType.toString());
}
