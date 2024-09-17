import 'package:flutter/material.dart';
import 'package:retro_logger/src/extensions/logger_time_extension.dart';
import 'package:retro_logger/src/log.dart';
import 'package:retro_logger/src/logger.dart';

class LogItemWidget extends StatelessWidget {
  final Log log;

  const LogItemWidget({required this.log, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Logger.getColor(log.level), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    log.level.toUpperCase(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Logger.getColor(log.level),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                  ),
                ),
                Text(
                  log.timestamp.format,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Logger.getColor(log.level),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              log.message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Logger.getColor(log.level),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
