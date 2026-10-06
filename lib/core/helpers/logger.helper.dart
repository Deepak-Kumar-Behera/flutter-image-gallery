import 'package:logger/logger.dart';

import '../consts/const.dart';
import '../enums/enum.dart';

class HLogger extends Logger {
  HLogger._privateConstructor() : super(printer: PrettyPrinter());
  static final HLogger instance = HLogger._privateConstructor();

  void logInfo(dynamic message) {
    if (CApp.env == EEnv.development) i(message);
  }

  void logError(dynamic message) {
    if (CApp.env == EEnv.development) e(message);
  }

  void logDebug(dynamic message) {
    if (CApp.env == EEnv.development) d(message);
  }
}
