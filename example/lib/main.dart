// ignore_for_file: prefer-single-widget-per-file, prefer-match-file-name

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:retro_logger/retro_logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LogScreen(),
    );
  }
}

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  @override
  void initState() {
    super.initState();
    _simulateLogs();
  }

  Future<void> _simulateLogs() async {
    // List of log types and corresponding messages
    final logMessages = [
      () => Logger.network('This is a network log', name: '_simulateLogs'),
      () => Logger.button('This is a button log', name: '_simulateLogs'),
      () => Logger.database('This is a database log', name: '_simulateLogs'),
      () => Logger.ui('This is a UI log', name: '_simulateLogs'),
      () => Logger.api('This is an API log', name: '_simulateLogs'),
      () => Logger.other('This is an other log', name: '_simulateLogs'),
      () => Logger.error('This is an error log', name: '_simulateLogs'),
      () => Logger.warning('This is a warning log', name: '_simulateLogs'),
      () => Logger.success('This is a success log', name: '_simulateLogs'),
      () => Logger.info('This is an info log', name: '_simulateLogs'),
      () => Logger.fatal('This is a fatal log', name: '_simulateLogs'),
      () => _benchmarkedLog(),
    ];

    // Loop over the log messages
    for (var logMessage in logMessages) {
      await Future.delayed(const Duration(milliseconds: 100), () {
        logMessage();
      });
    }
  }

  void _benchmarkedLog() {
    Logger.benchmarkAsync(
      () async {
        await Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Benchmark completed')),
          );
        });
      },
      (String elapsedTime) {
        Logger.timestamp(
          'Benchmark completed in $elapsedTime',
          name: '_simulateLogs',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Logs')),
        body: const SafeArea(child: LogTabView()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Logger.info(
              [
                'This is an info log',
                'with multiple lines',
                'and json data\n\n'
                    '{"key": "value", "list": [1, 2, 3], "nested": {"key": "value"}, "bool": true}, "null": null',
              ],
              name: 'FloatingActionButton',
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
