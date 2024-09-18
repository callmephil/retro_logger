import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retro_logger/src/utils/stop_watch_utils.dart';

import 'log.dart';
import 'log_manager.dart';

/// An enum representing different log levels with associated colors.
enum Logger {
  /// Error log level with red color.
  error('31', Colors.red, type: LogType.error),

  /// Success log level with green color.
  success('32', Colors.green, type: LogType.success),

  /// Info log level with yellow color.
  info('33', Colors.yellow, type: LogType.info),

  /// Warning log level with orange color.
  warning('34', Colors.orange, type: LogType.warning),

  /// Fatal log level with white color.
  fatal('35', Colors.white, type: LogType.fatal),

  /// Network log level with blue color.
  network('36', Colors.blue, type: LogType.network),

  /// Button log level with cyan color.
  button('37', Colors.cyan, type: LogType.button),

  /// Database log level with purple color.
  database('38', Colors.purple, type: LogType.database),

  /// UI log level with pink color.
  ui('39', Colors.pink, type: LogType.ui),

  /// API log level with teal color.
  api('40', Colors.teal, type: LogType.api),

  /// Other log level with grey color.
  other('41', Colors.grey, type: LogType.other),

  /// Benchmark log level with magenta color.
  timestamp('42', Colors.amberAccent, type: LogType.timestamp),
  ;

  /// Constructor for the [Logger] enum.
  ///
  /// [code] is the ANSI color code for the log level.
  /// [color] is the [Color] associated with the log level.
  const Logger(this.code, this.color, {this.type = LogType.other});

  /// The ANSI color code for the log level.
  final String code;

  /// The [Color] associated with the log level.
  final Color color;

  /// The [LogType] associated with the log level.
  final LogType type;

  /// Logs a message with the current log level.
  ///
  /// [message] is the message to be logged. If [message] is null, an empty string is logged.
  void log(Object? message, {required String origin}) {
    if (kDebugMode) {
      final logMessage = 'Logger.$name: \x1B[${code}m${message ?? ''}\x1B[0m';
      developer.log(logMessage, name: origin);
    }

    // Store the log in the LogManager singleton
    final logEntry = Log(
      level: name,
      origin: origin,
      message: message?.toString() ?? '',
      type: type,
    );
    LogManager.instance.addLog(logEntry);
  }

  /// Gets the [Color] associated with a log level.
  ///
  /// [level] is the name of the log level.
  /// Returns the [Color] associated with the log level, or the color for [Logger.info] if the level is not found.
  static Color getColor(String level) {
    return Logger.values
        .firstWhere((e) => e.name == level, orElse: () => Logger.info)
        .color;
  }

  /// Benchmarks the execution time of a synchronous function.
  ///
  /// [eval] is the function to be benchmarked.
  /// [name] is an optional name for the benchmark, used in the log message.
  void benchmark(void Function() eval, {String name = ''}) {
    StopWatchUtils.benchmark(
      eval,
      elapsedTime: (elapsedTime) =>
          Logger.timestamp.log(elapsedTime, origin: name),
    );
  }

  /// Benchmarks the execution time of an asynchronous function.
  ///
  /// [eval] is the asynchronous function to be benchmarked.
  /// [name] is an optional name for the benchmark, used in the log message.
  Future<void> benchmarkAsync(
    Future<void> Function() eval, {
    String name = '',
  }) async {
    await StopWatchUtils.benchmarkAsync(
      eval,
      elapsedTime: (elapsedTime) =>
          Logger.timestamp.log(elapsedTime, origin: name),
    );
  }
}
