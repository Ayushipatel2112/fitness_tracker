// ─── ProgressModel ───────────────────────────────────────────────────
// Represents a single progress entry (weight tracking over time).
// ─────────────────────────────────────────────────────────────────────

class ProgressModel {
  final String id;        // unique ID from database
  final String userId;    // which user this belongs to
  final double weight;    // user's weight in kg on this date
  final DateTime date;    // when this weight was recorded

  ProgressModel({
    required this.id,
    required this.userId,
    required this.weight,
    required this.date,
  });

  // Convert to Map (used when sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'weight': weight,
      'date': date.toIso8601String(),
    };
  }

  // Create from Map (used when reading from API)
  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      weight: (json['weight'] ?? 0).toDouble(),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Copy with modified fields
  ProgressModel copyWith({
    String? id,
    String? userId,
    double? weight,
    DateTime? date,
  }) {
    return ProgressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }
}
