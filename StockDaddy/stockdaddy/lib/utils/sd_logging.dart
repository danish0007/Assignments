import 'package:logging/logging.dart';

/// {@template sd.log.type}
/// Enum type used along with [SDLogging] to determine
/// how [Logger] messages will be recorded.
/// {@endtemplate}
enum SDLogType { console, file }

/// {@template sd.logging}
/// Logging class which helps in recording [Logger] messages.
/// {@endtemplate}
class SDLogging {
  // Private Constructor
  // Only support static methods
  SDLogging._();

  /// {@template sd.logging.initialize}
  /// Used to setup the logging level for [Logger],
  /// which determines that to log.
  ///
  /// Also, uses [SDLogType] to determine how to record the log messages.  ///
  /// {@endtemplate}
  static void setup({
    required SDLogType logTo,
    required Level level,
  }) {
    Logger.root.level = level;

    if (logTo == SDLogType.console) {
      _logToConsole();
    } else {
      _logToFile();
    }
  }

  static void _logToConsole() {
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.loggerName}: '
          '${record.message}');
    });
  }

  static void _logToFile() {
    throw UnsupportedError('Logging to file is not supported right now.');
  }
}
