import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:retro_logger/src/enums/log_level.dart';
import 'package:retro_logger/src/utils/stop_watch_utils.dart';

import 'log.dart';
import 'log_manager.dart';

class Logger {
  final LogLevel level;

  const Logger._(this.level);

  static Logger error(Object? message, {String name = 'unknown'}) {
    return _log(.error, message, name);
  }

  static Logger success(Object? message, {String name = 'unknown'}) {
    return _log(.success, message, name);
  }

  static Logger info(Object? message, {String name = 'unknown'}) {
    return _log(.info, message, name);
  }

  static Logger warning(Object? message, {String name = 'unknown'}) {
    return _log(.warning, message, name);
  }

  static Logger fatal(Object? message, {String name = 'unknown'}) {
    return _log(.fatal, message, name);
  }

  static Logger network(Object? message, {String name = 'unknown'}) {
    return _log(.network, message, name);
  }

  static Logger button(Object? message, {String name = 'unknown'}) {
    return _log(.button, message, name);
  }

  static Logger database(Object? message, {String name = 'unknown'}) {
    return _log(.database, message, name);
  }

  static Logger ui(Object? message, {String name = 'unknown'}) {
    return _log(.ui, message, name);
  }

  static Logger api(Object? message, {String name = 'unknown'}) {
    return _log(.api, message, name);
  }

  static Logger other(Object? message, {String name = 'unknown'}) {
    return _log(.other, message, name);
  }

  static Logger timestamp(Object? message, {String name = 'unknown'}) {
    return _log(.timestamp, message, name);
  }

  static Logger benchmark(
    void Function() eval,
    void Function(String) logCallback,
  ) {
    StopWatchUtils.benchmark(eval, elapsedTime: logCallback);
    return const Logger._(.timestamp);
  }

  static Logger benchmarkAsync(
    Future<void> Function() eval,
    void Function(String) logCallback,
  ) {
    StopWatchUtils.benchmarkAsync(eval, elapsedTime: logCallback);
    return const Logger._(.timestamp);
  }

  static Logger _log(LogLevel level, Object? message, String name) {
    if (kDebugMode) {
      final logMessage =
          'Logger.${level.name}: \x1B[${level.ansiCode}m${message ?? ''}\x1B[0m';
      developer.log(logMessage, name: name);
    }

    final logEntry = Log(
      level: level.name,
      name: name,
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
