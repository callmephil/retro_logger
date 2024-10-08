import 'package:retro_logger/src/enums/log_type.dart';

export 'package:retro_logger/src/enums/log_type.dart';

/// A class representing a log entry with a level, message, timestamp, name, and type.
class Log {
  /// The unique identifier of the log.
  final String name;

  /// The level of the log (e.g., 'info', 'error').
  final String level;

  /// The message of the log.
  final String message;

  /// The timestamp of when the log was created.
  final DateTime timestamp;

  /// The type of the log (e.g., 'network', 'button').
  final LogType type;

  /// Creates a new [Log] instance.
  ///
  /// If [timestamp] is not provided, it defaults to the current date and time.
  Log({
    required this.name,
    required this.level,
    required this.message,
    required this.type,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Creates a copy of this log with the given fields replaced with new values.
  ///
  /// If a field is not provided, the current value of that field is used.
  Log copyWith({
    String? name,
    String? level,
    String? message,
    LogType? type,
    DateTime? timestamp,
  }) {
    return Log(
      name: name ?? this.name,
      level: level ?? this.level,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Creates a new [Log] instance from a JSON object.
  ///
  /// The JSON object must contain the 'name', 'level', 'message', and 'type' fields.
  /// The 'timestamp' field is optional and defaults to the current date and time if not provided.
  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      name: json['name'] as String? ?? '',
      level: json['level'] as String? ?? 'unknown',
      message: json['message'] as String? ?? '',
      type: LogType.values.firstWhere(
        (e) => e.toString() == 'LogType.${json['type']}',
        orElse: () => LogType.other,
      ),
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

  /// Converts this [Log] instance to a JSON object.
  ///
  /// The resulting JSON object contains the 'name', 'level', 'message', 'type', and 'timestamp' fields.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'message': message,
      'type': type.toString(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Log(name: $name, level: $level, message: $message, type: $type, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Log &&
        other.name == name &&
        other.level == level &&
        other.message == message &&
        other.type == type &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        level.hashCode ^
        message.hashCode ^
        type.hashCode ^
        timestamp.hashCode;
  }
}
