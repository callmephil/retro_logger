import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retro_logger/src/enums/log_level.dart';
import 'package:retro_logger/src/utils/stop_watch_utils.dart';

import 'log.dart';
import 'log_manager.dart';

class Logger {
  final LogLevel level;

  const Logger._(this.level);

  static Logger error(Object? message, {required String origin}) {
    return _log(LogLevel.error, message, origin);
  }

  static Logger success(Object? message, {required String origin}) {
    return _log(LogLevel.success, message, origin);
  }

  static Logger info(Object? message, {required String origin}) {
    return _log(LogLevel.info, message, origin);
  }

  static Logger warning(Object? message, {required String origin}) {
    return _log(LogLevel.warning, message, origin);
  }

  static Logger fatal(Object? message, {required String origin}) {
    return _log(LogLevel.fatal, message, origin);
  }

  static Logger network(Object? message, {required String origin}) {
    return _log(LogLevel.network, message, origin);
  }

  static Logger button(Object? message, {required String origin}) {
    return _log(LogLevel.button, message, origin);
  }

  static Logger database(Object? message, {required String origin}) {
    return _log(LogLevel.database, message, origin);
  }

  static Logger ui(Object? message, {required String origin}) {
    return _log(LogLevel.ui, message, origin);
  }

  static Logger api(Object? message, {required String origin}) {
    return _log(LogLevel.api, message, origin);
  }

  static Logger other(Object? message, {required String origin}) {
    return _log(LogLevel.other, message, origin);
  }

  static Logger timestamp(Object? message, {required String origin}) {
    return _log(LogLevel.timestamp, message, origin);
  }

  static Logger benchmark(
    void Function() eval,
    void Function(String) logCallback,
  ) {
    StopWatchUtils.benchmark(eval, elapsedTime: logCallback);
    return const Logger._(LogLevel.timestamp);
  }

  static Logger benchmarkAsync(
    Future<void> Function() eval,
    void Function(String) logCallback,
  ) {
    StopWatchUtils.benchmarkAsync(eval, elapsedTime: logCallback);
    return const Logger._(LogLevel.timestamp);
  }

  static Logger _log(LogLevel level, Object? message, String origin) {
    if (kDebugMode) {
      final logMessage =
          'Logger.${level.name}: \x1B[${level.ansiCode}m${message ?? ''}\x1B[0m';
      developer.log(logMessage, name: origin);
    }

    final logEntry = Log(
      level: level.name,
      origin: origin,
      message: message?.toString() ?? '',
      type: level.type,
    );
    LogManager.instance.addLog(logEntry);

    return Logger._(level);
  }

  static Color getColor(String levelName) {
    return LogLevel.values
        .firstWhere(
          (level) => level.name == levelName,
          orElse: () => LogLevel.info,
        )
        .color;
  }

  static Color getColorByType(LogType type) {
    return LogLevel.values
        .firstWhere((level) => level.type == type, orElse: () => LogLevel.info)
        .color;
  }
}
