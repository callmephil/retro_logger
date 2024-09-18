import 'package:flutter/material.dart';
import 'package:retro_logger/retro_logger.dart';

class LogListWidget extends StatefulWidget {
  const LogListWidget({super.key});

  @override
  State<LogListWidget> createState() => _LogListWidgetState();
}

class _LogListWidgetState extends State<LogListWidget> {
  final TextEditingController _controller = TextEditingController();
  final LogManager _logManager = LogManager.instance;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Search Logs',
              border: OutlineInputBorder(),
            ),
            onChanged: _logManager.debouncedSearchLogs,
          ),
        ),
        Expanded(
          child: LogManagerWidget(
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
          ),
        ),
      ],
    );
  }
}
