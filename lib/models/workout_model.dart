// ─── WorkoutModel ────────────────────────────────────────────────────
// Represents a single workout entry logged by the user.
// A Model is just a Dart class that holds data from the database/API.
// ─────────────────────────────────────────────────────────────────────

class WorkoutModel {
  final String id;         // unique ID from database
  final String userId;     // which user added this workout
  final String name;       // workout name e.g. "Running"
  final int duration;      // how long in minutes e.g. 30
  final int calories;      // calories burned e.g. 200
  final DateTime date;     // when the workout was done

  WorkoutModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.duration,
    required this.calories,
    required this.date,
  });

  // Convert WorkoutModel to a Map (used when sending to API or saving locally)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'duration': duration,
      'calories': calories,
      'date': date.toIso8601String(), // convert DateTime to string
    };
  }

  // Create a WorkoutModel from a Map (used when reading from API or local storage)
  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      duration: json['duration'] ?? 0,
      calories: json['calories'] ?? 0,
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Copy with: create a new object with some fields changed
  WorkoutModel copyWith({
    String? id,
    String? userId,
    String? name,
    int? duration,
    int? calories,
    DateTime? date,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      calories: calories ?? this.calories,
      date: date ?? this.date,
    );
  }
}
