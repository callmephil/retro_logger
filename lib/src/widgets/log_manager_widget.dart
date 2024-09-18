import 'package:flutter/material.dart';
import 'package:retro_logger/src/log.dart';
import 'package:retro_logger/src/log_manager.dart';

class LogManagerWidget extends StatelessWidget {
  const LogManagerWidget({super.key, required this.builder});

  final Widget Function(BuildContext context, List<Log> logs) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LogManager.instance.filteredLogsNotifier,
      builder: (BuildContext ctx, List<Log> logs, __) {
        return builder(ctx, logs);
      },
    );
  }
}
