class StopWatchUtils {
  const StopWatchUtils._();

  static String _formatTime(int milliseconds) {
    final hundreds = (milliseconds / 10).truncate();
    final seconds = (hundreds / 100).truncate();
    final minutes = (seconds / 60).truncate();

    final minutesStr = (minutes % 60).toString().padLeft(2, '0');
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');
    final hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr:$hundredsStr';
  }

  static void benchmark(
    void Function() function, {
    void Function(String)? elapsedTime,
  }) {
    final stopwatch = Stopwatch()..start();
    function();
    stopwatch.stop();

    elapsedTime?.call(_formatTime(stopwatch.elapsedMilliseconds));
  }

  static Future<void> benchmarkAsync(
    Future<void> Function() function, {
    void Function(String)? elapsedTime,
  }) async {
    final stopwatch = Stopwatch()..start();
    await function();
    stopwatch.stop();

    elapsedTime?.call(_formatTime(stopwatch.elapsedMilliseconds));
  }
}
