class Meal {
  final String id;
  final String userId;
  final String name;
  final String type;
  final int calories;
  final String notes;
  final String date;

  Meal({
    this.id = '',
    required this.userId,
    required this.name,
    required this.type,
    required this.calories,
    required this.notes,
    required this.date,
  });

  Map<String, Object> toMap() {
    return {
      'userId': userId,
      'name': name,
      'type': type,
      'calories': calories,
      'notes': notes,
      'date': date,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map, String id) {
    return Meal(
      id: id,
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? 'Breakfast',
      calories: map['calories']?.toInt() ?? 0,
      notes: map['notes'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
