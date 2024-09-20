/// Extension on DateTime to provide a human-readable time format.
extension LoggerTimeExtension on DateTime {
  /// Returns a human-readable time format.
  ///
  /// If the date is yesterday, it includes the date in the format `yyyy-MM-dd HH:mm:ss.SS`.
  /// For all other times, it displays the time in 24-hour format `HH:mm:ss.SS`.
  String get format {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final dateToCompare = DateTime(year, month, day);

    final millisecondsTwoDigits =
        (millisecond ~/ 10).toString().padLeft(2, '0');

    if (dateToCompare.year == yesterday.year &&
        dateToCompare.month == yesterday.month &&
        dateToCompare.day == yesterday.day) {
      // If the time was set yesterday, include the date
      return '${year.toString().padLeft(4, '0')}-'
          '${month.toString().padLeft(2, '0')}-'
          '${day.toString().padLeft(2, '0')} '
          '${hour.toString().padLeft(2, '0')}:'
          '${minute.toString().padLeft(2, '0')}:'
          '${second.toString().padLeft(2, '0')}.'
          '$millisecondsTwoDigits';
    }

    // For all other times, display time in 24-hour format
    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}:'
        '${second.toString().padLeft(2, '0')}.'
        '$millisecondsTwoDigits';
  }
}
