import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:retro_logger/src/utils/stop_watch_utils.dart';

import 'log.dart';
import 'log_manager.dart';

enum Logger {
  error('31', Colors.red),
  success('32', Colors.green),
  info('33', Colors.yellow),
  warning('34', Colors.orange),
  debug('36', Colors.blue);

  const Logger(this.code, this.color);
  final String code;
  final Color color;

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

  static Color getColor(String level) {
    return Logger.values
        .firstWhere((e) => e.name == level, orElse: () => Logger.info)
        .color;
  }

  void benchmark(void Function() eval, {String name = ''}) {
    StopWatchUtils.benchmark(
      eval,
      elapsedTime: (value) => log('execution time for $name is $value'),
    );
  }

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
