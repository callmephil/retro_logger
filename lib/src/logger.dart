import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:retro_logger/src/utils/stop_watch_utils.dart';

import 'log.dart';
import 'log_manager.dart';

/// An enum representing different log levels with associated colors.
enum Logger {
  /// Error log level with red color.
  error('31', Colors.red),

  /// Success log level with green color.
  success('32', Colors.green),

  /// Info log level with yellow color.
  info('33', Colors.yellow),

  /// Warning log level with orange color.
  warning('34', Colors.orange),

  /// Debug log level with blue color.
  debug('36', Colors.blue);

  /// Constructor for the [Logger] enum.
  ///
  /// [code] is the ANSI color code for the log level.
  /// [color] is the [Color] associated with the log level.
  const Logger(this.code, this.color);

  /// The ANSI color code for the log level.
  final String code;

  /// The [Color] associated with the log level.
  final Color color;

  /// Logs a message with the current log level.
  ///
  /// [message] is the message to be logged. If [message] is null, an empty string is logged.
  void log(Object? message) {
    final logMessage = 'Logger.$name: \x1B[${code}m${message ?? ''}\x1B[0m';
    developer.log(logMessage);

    // Store the log in the LogManager singleton
    final logEntry = Log(
      level: name,
      message: message?.toString() ?? '',
      timestamp: DateTime.now(),
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
      elapsedTime: (value) => log('execution time for $name is $value'),
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
      elapsedTime: (value) => log('execution time for $name is $value'),
    );
  }
}
