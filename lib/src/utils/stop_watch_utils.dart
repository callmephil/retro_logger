/// A utility class for benchmarking the execution time of functions.
class StopWatchUtils {
  /// Private constructor to prevent instantiation.
  const StopWatchUtils._();

  /// Formats the given time in milliseconds to a string in the format mm:ss:hh.
  ///
  /// [milliseconds] is the time to be formatted.
  /// Returns a string representing the formatted time.
  static String _formatTime(int milliseconds) {
    final hundreds = (milliseconds / 10).truncate();
    final seconds = (hundreds / 100).truncate();
    final minutes = (seconds / 60).truncate();

    final minutesStr = (minutes % 60).toString().padLeft(2, '0');
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');
    final hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr:$hundredsStr';
  }

  /// Benchmarks the execution time of a synchronous function.
  ///
  /// [function] is the function to be benchmarked.
  /// [elapsedTime] is an optional callback that receives the formatted elapsed time as a string.
  static void benchmark(
    void Function() function, {
    void Function(String)? elapsedTime,
  }) {
    final stopwatch = Stopwatch()..start();
    function();
    stopwatch.stop();

    elapsedTime?.call(_formatTime(stopwatch.elapsedMilliseconds));
  }

  /// Benchmarks the execution time of an asynchronous function.
  ///
  /// [function] is the asynchronous function to be benchmarked.
  /// [elapsedTime] is an optional callback that receives the formatted elapsed time as a string.
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
