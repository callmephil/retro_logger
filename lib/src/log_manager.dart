import 'dart:async';

import 'package:flutter/foundation.dart';

import 'log.dart';

/// A singleton class that manages logs and provides search functionality.
class LogManager {
  /// Factory constructor to return the singleton instance.
  factory LogManager() => _instance;

  /// Private constructor to prevent external instantiation.
  LogManager._internal() {
    _filteredLogsNotifier.value = List.unmodifiable(_logs);
  }

  /// The singleton instance of [LogManager].
  static final LogManager _instance = LogManager._internal();

  /// Getter to access the singleton instance of [LogManager].
  static LogManager get instance => _instance;

  /// A list to store all log entries.
  final List<Log> _logs = [];

  List<Log> get logs => List.unmodifiable(_logs);

  /// A [ValueNotifier] to notify listeners of filtered log entries.
  final ValueNotifier<List<Log>> _filteredLogsNotifier = ValueNotifier([]);

  /// A timer to handle debounced search functionality.
  Timer? _debounceTimer;

  /// A set to store the current log type filters.
  Set<LogType> _currentLogTypes = {};

  /// A string to store the current search query.
  String _currentSearchQuery = '';

  /// Getter to access the [ValueNotifier] for filtered logs.
  ValueNotifier<List<Log>> get filteredLogsNotifier => _filteredLogsNotifier;

  /// Adds a new log entry to the list and updates the search results.
  ///
  /// [log] is the log entry to be added.
  void addLog(Log log) {
    _logs.add(log);
    _applyCurrentFilters();
  }

  /// Clears all log entries and updates the search results.
  void clearLogs() {
    _logs.clear();
    _filteredLogsNotifier.value = [];
  }

  /// Searches the logs based on the provided query and updates the search results.
  ///
  /// [query] is the search term used to filter the logs.
  void searchLogs(String query) {
    _currentSearchQuery = query;
    _applyCurrentFilters();
  }

  /// Filters the logs based on the provided log types and updates the search results.
  ///
  /// [logTypes] is the set of log types used to filter the logs.
  void filterLogsByTypes(Set<LogType> logTypes) {
    _currentLogTypes = logTypes;
    _applyCurrentFilters();
  }

  /// Applies the current filters to the log list and updates the filtered logs notifier.
  void _applyCurrentFilters() {
    List<Log> filteredLogs = _logs;

    if (_currentLogTypes.isNotEmpty) {
      filteredLogs = filteredLogs
          .where((log) => _currentLogTypes.contains(log.type))
          .toList(growable: false);
    }

    if (_currentSearchQuery.isNotEmpty) {
      final searchWords = _currentSearchQuery.toLowerCase().split(' ');
      filteredLogs = filteredLogs.where((log) {
        final logFields = [
          log.message.toLowerCase(),
          log.level.toLowerCase(),
          log.name.toLowerCase(),
          log.type.name.toLowerCase(),
        ];
        return searchWords
            .any((word) => logFields.any((field) => field.contains(word)));
      }).toList(growable: false);
    }

    _filteredLogsNotifier.value = List.unmodifiable(filteredLogs);
  }

  /// Performs a debounced search on the logs based on the provided query.
  ///
  /// [query] is the search term used to filter the logs.
  /// [debounceDuration] is the duration to wait before performing the search.
  /// Defaults to 300 milliseconds.
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
