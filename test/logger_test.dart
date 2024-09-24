import 'package:flutter_test/flutter_test.dart';
import 'package:retro_logger/retro_logger.dart';

void main() {
  group('LogManager', () {
    late LogManager logManager;

    setUp(() {
      logManager = LogManager();
      logManager.clearLogs();
    });

    test('should add a log', () {
      final log = Log(
        name: 'test: should add a log',
        level: 'info',
        message: 'This is a test log',
        timestamp: DateTime.now(),
        type: LogType.other,
      );

      logManager.addLog(log);

      expect(logManager.logs.length, 1);
      expect(logManager.logs.firstOrNull, log);
    });

    test('should retrieve logs', () {
      final log1 = Log(
        name: 'test: should retrieve logs',
        level: 'info',
        message: 'First log',
        timestamp: DateTime.now(),
        type: LogType.other,
      );
      final log2 = Log(
        name: 'test: should retrieve logs',
        level: 'error',
        message: 'Second log',
        timestamp: DateTime.now(),
        type: LogType.other,
      );

      logManager.addLog(log1);
      logManager.addLog(log2);

      expect(logManager.logs.length, 2);
      expect(logManager.logs.elementAtOrNull(0), log1);
      expect(logManager.logs.elementAtOrNull(1), log2);
    });

    test('should clear logs', () {
      final log = Log(
        name: 'test: should clear logs',
        level: 'info',
        message: 'This is a test log',
        timestamp: DateTime.now(),
        type: LogType.other,
      );

      logManager.addLog(log);
      expect(logManager.logs.length, 1);

      logManager.clearLogs();
      expect(logManager.logs.length, 0);
    });
  });
}
