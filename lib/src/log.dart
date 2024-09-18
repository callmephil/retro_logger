/// A class representing a log entry with a level, message, and timestamp.
class Log {
  /// The level of the log (e.g., 'info', 'error').
  final String level;

  /// The message of the log.
  final String message;

  /// The timestamp of when the log was created.
  final DateTime timestamp;

  /// Creates a new [Log] instance.
  ///
  /// If [timestamp] is not provided, it defaults to the current date and time.
  Log({required this.level, required this.message, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  /// Creates a copy of this log with the given fields replaced with new values.
  ///
  /// If a field is not provided, the current value of that field is used.
  Log copyWith({String? level, String? message, DateTime? timestamp}) {
    return Log(
      level: level ?? this.level,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Creates a new [Log] instance from a JSON object.
  ///
  /// The JSON object must contain the 'level' and 'message' fields.
  /// The 'timestamp' field is optional and defaults to the current date and time if not provided.
  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      level: json['level'] as String? ?? 'unknown',
      message: json['message'] as String? ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

  /// Converts this [Log] instance to a JSON object.
  ///
  /// The resulting JSON object contains the 'level', 'message', and 'timestamp' fields.
  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Log(level: $level, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Log &&
        other.level == level &&
        other.message == message &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return level.hashCode ^ message.hashCode ^ timestamp.hashCode;
  }
}
