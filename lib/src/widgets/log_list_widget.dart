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
  final Set<LogType> _selectedLogTypes = {};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSelectedLogType(LogType selectedType) {
    final hasSelectedType = _selectedLogTypes.any((e) => e == selectedType);
    if (hasSelectedType) {
      _selectedLogTypes.remove(selectedType);
    } else {
      _selectedLogTypes.add(selectedType);
    }

    _logManager.filterLogsByTypes(_selectedLogTypes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0).copyWith(bottom: 4),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              suffixIcon: PopupMenuButton<LogType>(
                icon: const Icon(Icons.filter_list),
                onSelected: _onSelectedLogType,
                itemBuilder: (BuildContext _) {
                  return LogType.values.map((LogType logType) {
                    return CheckedPopupMenuItem<LogType>(
                      value: logType,
                      checked: _selectedLogTypes.contains(logType),
                      child: Text(logType.name),
                    );
                  }).toList(growable: false);
                },
              ),
              labelText: 'Search Logs',
              border: const OutlineInputBorder(),
            ),
            onChanged: (query) {
              _logManager.debouncedSearchLogs(query);
            },
          ),
        ),
        Expanded(
          child: LogManagerWidget(
            builder: (_, logs) {
              return ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                itemCount: logs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (__, index) {
                  final log = logs[index];
                  return LogItemWidget(log: log);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
