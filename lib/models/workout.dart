class Workout {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String workoutType;
  final int durationMinutes;
  final int caloriesBurned;
  final String date;

  Workout({
    this.id = '',
    required this.userId,
    required this.title,
    required this.description,
    required this.workoutType,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.date,
  });

  Map<String, Object> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'workoutType': workoutType,
      'durationMinutes': durationMinutes,
      'caloriesBurned': caloriesBurned,
      'date': date,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map, String id) {
    return Workout(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      workoutType: map['workoutType'] ?? 'Strength',
      durationMinutes: map['durationMinutes']?.toInt() ?? 0,
      caloriesBurned: map['caloriesBurned']?.toInt() ?? 0,
      date: map['date'] ?? '',
    );
  }
}
