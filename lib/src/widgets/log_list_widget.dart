import 'package:flutter/material.dart';
import 'package:retro_logger/src/widgets/log_item_widget.dart';
import 'package:retro_logger/src/widgets/log_manager_widget.dart';

class LogListWidget extends StatelessWidget {
  const LogListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LogManagerWidget(
      builder: (_, logs) {
        return ColoredBox(
          color: Colors.black,
          child: ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: logs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (__, index) {
              final log = logs[index];
              return LogItemWidget(log: log);
            },
          ),
        );
      },
    );
  }
}
