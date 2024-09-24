import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for clipboard functionality
import 'package:retro_logger/src/extensions/logger_time_extension.dart';
import 'package:retro_logger/src/log.dart';
import 'package:retro_logger/src/logger.dart';

class LogItemWidget extends StatelessWidget {
  final Log log;

  const LogItemWidget({required this.log, super.key});

  static const _gap = 8.0;

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    final color = Logger.getColor(log.level);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SelectableRegion(
          focusNode: focusNode,
          selectionControls: MaterialTextSelectionControls(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${log.level} (${log.name})'.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: color,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                    ),
                  ),
                  Text(
                    log.timestamp.format,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                  ),
                  const SizedBox(width: _gap),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    color: color,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: log.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Log copied to clipboard'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: _gap),
              Text(
                log.message,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: color,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
