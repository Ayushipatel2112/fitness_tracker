// ─── SleepModel ──────────────────────────────────────────────────────
// Represents a single sleep log entry.
// ─────────────────────────────────────────────────────────────────────

class SleepModel {
  final String id;        // unique ID from database
  final String userId;    // which user logged this sleep
  final double hours;     // sleep duration in hours e.g. 7.5
  final DateTime date;    // which night was this sleep for

  SleepModel({
    required this.id,
    required this.userId,
    required this.hours,
    required this.date,
  });

  // Convert to Map (used when sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'hours': hours,
      'date': date.toIso8601String(),
    };
  }

  // Create from Map (used when reading from API)
  factory SleepModel.fromJson(Map<String, dynamic> json) {
    return SleepModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      hours: (json['hours'] ?? 0).toDouble(),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Copy with modified fields
  SleepModel copyWith({
    String? id,
    String? userId,
    double? hours,
    DateTime? date,
  }) {
    return SleepModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      hours: hours ?? this.hours,
      date: date ?? this.date,
    );
  }
}
