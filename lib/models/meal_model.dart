// ─── MealModel ───────────────────────────────────────────────────────
// Represents a single meal entry logged by the user.
// ─────────────────────────────────────────────────────────────────────

class MealModel {
  final String id;         // unique ID from database
  final String userId;     // which user added this meal
  final String type;       // meal type: 'Breakfast', 'Lunch', or 'Dinner'
  final String foodName;   // name of food e.g. "Oatmeal"
  final int calories;      // calories in this meal e.g. 350
  final DateTime date;     // when this meal was eaten

  MealModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.foodName,
    required this.calories,
    required this.date,
  });

  // Convert to Map (used when sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'food_name': foodName,
      'calories': calories,
      'date': date.toIso8601String(),
    };
  }

  // Create from Map (used when reading from API)
  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      type: json['type'] ?? 'Breakfast',
      foodName: json['food_name'] ?? '',
      calories: json['calories'] ?? 0,
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Copy with modified fields
  MealModel copyWith({
    String? id,
    String? userId,
    String? type,
    String? foodName,
    int? calories,
    DateTime? date,
  }) {
    return MealModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      foodName: foodName ?? this.foodName,
      calories: calories ?? this.calories,
      date: date ?? this.date,
    );
  }
}
