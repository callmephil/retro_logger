import 'package:flutter/services.dart'; // Import for clipboard functionality
import 'package:material_ui/material_ui.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: .all(color: color, width: 1),
        borderRadius: .circular(8),
      ),
      child: Padding(
        padding: const .all(10),
        child: SelectableRegion(
          focusNode: focusNode,
          selectionControls: MaterialTextSelectionControls(),
          child: Column(
            spacing: _gap,
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${log.level} (${log.name})'.toUpperCase(),
                      style: textTheme.labelMedium?.copyWith(
                        color: color,
                        fontWeight: .bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Text(
                    log.timestamp.format,
                    style: textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: .bold,
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
              Text(
                log.message,
                style: textTheme.bodyLarge?.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
