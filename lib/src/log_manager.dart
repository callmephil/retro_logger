import 'dart:async';

import 'package:flutter/foundation.dart';

import 'log.dart';

/// A singleton class that manages logs and provides search functionality.
class LogManager {
  /// Factory constructor to return the singleton instance.
  factory LogManager() => _instance;

  /// Private constructor to prevent external instantiation.
  LogManager._internal();

  /// The singleton instance of [LogManager].
  static final LogManager _instance = LogManager._internal();

  /// Getter to access the singleton instance of [LogManager].
  static LogManager get instance => _instance;

  /// A list to store all log entries.
  final List<Log> _logs = [];

  /// A [ValueNotifier] to notify listeners of search results.
  final ValueNotifier<List<Log>> _searchResultsNotifier = ValueNotifier([]);

  /// A timer to handle debounced search functionality.
  Timer? _debounceTimer;

  /// Getter to access the [ValueNotifier] for search results.
  ValueNotifier<List<Log>> get searchResultsNotifier => _searchResultsNotifier;

  /// Getter to access an unmodifiable view of all logs.
  List<Log> get logs => List.unmodifiable(_logs);

  /// Adds a new log entry to the list and updates the search results.
  ///
  /// [log] is the log entry to be added.
  void addLog(Log log) {
    _logs.add(log);
    _searchResultsNotifier.value = List.unmodifiable(_logs);
  }

  /// Clears all log entries and updates the search results.
  void clearLogs() {
    _logs.clear();
    _searchResultsNotifier.value = List.unmodifiable(_logs);
  }

  /// Searches the logs based on the provided query and updates the search results.
  ///
  /// [query] is the search term used to filter the logs.
  void searchLogs(String query) {
    final results = _logs.where((log) {
      return log.message.toLowerCase().contains(query.toLowerCase()) ||
          log.level.toLowerCase().contains(query.toLowerCase());
    }).toList(growable: false);
    _searchResultsNotifier.value = List.unmodifiable(results);
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
