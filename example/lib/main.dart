import 'dart:async';

import 'package:flutter/material.dart';
import 'package:retro_logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
    await Future.delayed(const Duration(seconds: 1));
    Logger.debug.log('This is a debug log');
    await Future.delayed(const Duration(seconds: 1));
    Logger.info.log('This is an info log');
    await Future.delayed(const Duration(seconds: 1));
    Logger.success.log('This is a success log');
    await Future.delayed(const Duration(seconds: 1));
    Logger.error.log('This is an error log');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      body: LogManagerWidget(
        builder: (context, logs) {
          return const LogListWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Logger.info.log([
            'This is an info log',
            'with multiple lines',
            'and json data\n\n'
                '{"key": "value", "list": [1, 2, 3], "nested": {"key": "value"}, "bool": true}, "null": null',
          ]);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
