import 'package:material_ui/material_ui.dart' show Colors, Color;
import 'package:retro_logger/retro_logger.dart';

enum LogLevel {
  error('31', Colors.red, .error),
  success('32', Colors.green, .success),
  info('33', Colors.yellow, .info),
  warning('34', Colors.orange, .warning),
  fatal('35', Colors.white, .fatal),
  network('36', Colors.blue, .network),
  button('37', Colors.cyan, .button),
  database('38', Colors.purple, .database),
  ui('39', Colors.pink, .ui),
  api('40', Colors.teal, .api),
  other('41', Colors.grey, .other),
  timestamp('42', Colors.amberAccent, .timestamp);

  final String ansiCode;
  final Color color;
  final LogType type;

  const LogLevel(this.ansiCode, this.color, this.type);
}
