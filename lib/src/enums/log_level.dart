import 'package:flutter/material.dart' show Colors, Color;
import 'package:retro_logger/retro_logger.dart';

enum LogLevel {
  error('31', Colors.red, LogType.error),
  success('32', Colors.green, LogType.success),
  info('33', Colors.yellow, LogType.info),
  warning('34', Colors.orange, LogType.warning),
  fatal('35', Colors.white, LogType.fatal),
  network('36', Colors.blue, LogType.network),
  button('37', Colors.cyan, LogType.button),
  database('38', Colors.purple, LogType.database),
  ui('39', Colors.pink, LogType.ui),
  api('40', Colors.teal, LogType.api),
  other('41', Colors.grey, LogType.other),
  timestamp('42', Colors.amberAccent, LogType.timestamp);

  final String ansiCode;
  final Color color;
  final LogType type;

  const LogLevel(this.ansiCode, this.color, this.type);
}
