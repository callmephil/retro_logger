import 'dart:async';

import 'package:flutter/foundation.dart';

import 'log.dart';

class LogManager {
  factory LogManager() => _instance;
  LogManager._internal();
  static final LogManager _instance = LogManager._internal();
  static LogManager get instance => _instance;

  final List<Log> _logs = [];
  final ValueNotifier<List<Log>> _searchResultsNotifier = ValueNotifier([]);
  Timer? _debounceTimer;

  ValueNotifier<List<Log>> get searchResultsNotifier => _searchResultsNotifier;

  List<Log> get logs => List.unmodifiable(_logs);

  void addLog(Log log) {
    _logs.add(log);
    _searchResultsNotifier.value = List.unmodifiable(_logs);
  }

  void clearLogs() {
    _logs.clear();
    _searchResultsNotifier.value = List.unmodifiable(_logs);
  }

  void searchLogs(String query) {
    final results = _logs.where((log) {
      return log.message.toLowerCase().contains(query.toLowerCase()) ||
          log.level.toLowerCase().contains(query.toLowerCase());
    }).toList(growable: false);
    _searchResultsNotifier.value = List.unmodifiable(results);
  }

  void debouncedSearchLogs(
    String query, {
    Duration debounceDuration = const Duration(milliseconds: 300),
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(debounceDuration, () {
      searchLogs(query);
    });
  }
}
