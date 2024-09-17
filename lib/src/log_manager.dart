import 'package:flutter/foundation.dart';

import 'log.dart';

class LogManager {
  factory LogManager() => _instance;
  LogManager._internal();
  static final LogManager _instance = LogManager._internal();
  static LogManager get instance => _instance;

  final List<Log> _logs = [];
  final ValueNotifier<List<Log>> _logsNotifier = ValueNotifier([]);

  ValueNotifier<List<Log>> get logsNotifier => _logsNotifier;

  List<Log> get logs => List.unmodifiable(_logs);

  void addLog(Log log) {
    _logs.add(log);
    _logsNotifier.value = List.unmodifiable(_logs);
  }

  void clearLogs() {
    _logs.clear();
    _logsNotifier.value = List.unmodifiable(_logs);
  }
}
