import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retro_logger/retro_logger.dart';

// ignore: prefer-match-file-name
enum LogViewType {
  groupByOrigin,
  ascendingTime,
  descendingTime,
}

class LogListWidget extends StatefulWidget {
  const LogListWidget({super.key});

  @override
  State<LogListWidget> createState() => _LogListWidgetState();
}

class _LogListWidgetState extends State<LogListWidget> {
  final TextEditingController _controller = TextEditingController();
  final LogManager _logManager = LogManager.instance;
  final Set<LogType> _selectedLogTypes = {};
  LogViewType _selectedViewType = LogViewType.ascendingTime;

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

  void _onSelectedViewType(LogViewType viewType) {
    setState(() {
      _selectedViewType = viewType;
    });
  }

  List<Log> _getSortedLogs(List<Log> logs) {
    final modifiableLogs = List<Log>.of(logs);
    switch (_selectedViewType) {
      case LogViewType.groupByOrigin:
        // Group logs by origin
        break;
      case LogViewType.ascendingTime:
        modifiableLogs.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        break;
      case LogViewType.descendingTime:
        modifiableLogs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        break;
    }
    return modifiableLogs;
  }

  Map<String, Map<LogType, List<Log>>> _groupLogsByOrigin(List<Log> logs) {
    final Map<String, Map<LogType, List<Log>>> groupedLogs = {};
    for (var log in logs) {
      groupedLogs.putIfAbsent(log.origin, () => {});
      groupedLogs[log.origin]!.putIfAbsent(log.type, () => []);
      groupedLogs[log.origin]![log.type]!.add(log);
    }
    return groupedLogs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0).copyWith(bottom: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    suffixIcon: PopupMenuButton<LogType>(
                      icon: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.filter_list),
                          SizedBox(width: 4),
                          Text('Filters'),
                          SizedBox(width: 4),
                        ],
                      ),
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
                    labelText: 'Search by keywords, origin, or type',
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    _logManager.debouncedSearchLogs(query);
                  },
                ),
              ),
              const SizedBox(width: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: DropdownButtonFormField<LogViewType>(
                  value: _selectedViewType,
                  decoration: const InputDecoration(
                    labelText: 'View by',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (LogViewType? newValue) {
                    if (newValue != null) {
                      _onSelectedViewType(newValue);
                    }
                  },
                  items: LogViewType.values.map((LogViewType viewType) {
                    return DropdownMenuItem<LogViewType>(
                      value: viewType,
                      child: Text(viewType.name),
                    );
                  }).toList(growable: false),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LogManagerWidget(
            builder: (_, logs) {
              if (_selectedViewType == LogViewType.groupByOrigin) {
                final groupedLogs = _groupLogsByOrigin(logs);
                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  children: groupedLogs.entries.expand((entry) {
                    final origin = entry.key;
                    return entry.value.entries.map((typeEntry) {
                      final type = typeEntry.key;
                      final logEntries = typeEntry.value;
                      return ExpandableLogGroup(
                        origin: origin,
                        type: type,
                        logs: logEntries,
                      );
                    }).toList(growable: false);
                  }).toList(growable: false),
                );
              }
              final sortedLogs = _getSortedLogs(logs);
              return ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                itemCount: sortedLogs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (__, index) {
                  final log = sortedLogs[index];
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

class ExpandableLogGroup extends StatefulWidget {
  final String origin;
  final LogType type;
  final List<Log> logs;

  const ExpandableLogGroup({
    required this.origin,
    required this.type,
    required this.logs,
    super.key,
  });

  @override
  State<ExpandableLogGroup> createState() => _ExpandableLogGroupState();
}

class _ExpandableLogGroupState extends State<ExpandableLogGroup> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final color = Logger.getColorByType(widget.type);

    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Logger.getColorByType(widget.type)),
        ),
        child: ExpansionTile(
          title: Text(
            '${widget.type.name} ${widget.origin} (${widget.logs.length})'
                .toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          trailing: IconButton(
            icon: Icon(Icons.copy_all_rounded, color: color),
            onPressed: () {
              // Copy the logs to clipboard
              final logMessages =
                  widget.logs.map((log) => log.message).join('\n');
              Clipboard.setData(ClipboardData(text: logMessages));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logs copied to clipboard')),
              );
            },
          ),
          children: _isExpanded
              ? widget.logs.map((log) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: color),
                      ),
                      title: Text(log.message),
                      subtitle: Text(log.timestamp.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.copy, color: color),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: log.message));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Log copied to clipboard'),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(growable: false)
              : [],
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
        ),
      ),
    );
  }
}

class LogAnalyticsWidget extends StatelessWidget {
  const LogAnalyticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logManager = LogManager.instance;
    final logs = logManager.logs;

    final logTypeCounts = <LogType, int>{};
    for (var log in logs) {
      logTypeCounts[log.type] = (logTypeCounts[log.type] ?? 0) + 1;
    }

    final pieChartSections = logTypeCounts.entries.map((entry) {
      final logType = entry.key;
      final count = entry.value;
      return PieChartSectionData(
        value: count.toDouble(),
        title: '${logType.name} ($count)',
        color: Logger.getColorByType(logType),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          sections: pieChartSections,
          centerSpaceRadius: 80,
          sectionsSpace: 4,
        ),
      ),
    );
  }
}

class LogTabView extends StatelessWidget {
  const LogTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Logs and Analytics'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Logs'), Tab(text: 'Analytics')],
          ),
        ),
        body: const TabBarView(
          children: [LogListWidget(), LogAnalyticsWidget()],
        ),
      ),
    );
  }
}
