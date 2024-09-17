class Log {
  final String level;
  final String message;
  final DateTime timestamp;

  Log({required this.level, required this.message, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  Log copyWith({String? level, String? message, DateTime? timestamp}) {
    return Log(
      level: level ?? this.level,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      level: json['level'] as String? ?? 'unknown',
      message: json['message'] as String? ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

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
