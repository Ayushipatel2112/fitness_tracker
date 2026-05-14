class SleepRecord {
  final String id;
  final String userId;
  final String sleepDate;
  final String bedTime;
  final String wakeTime;
  final int hoursSlept;
  final String notes;

  SleepRecord({
    this.id = '',
    required this.userId,
    required this.sleepDate,
    required this.bedTime,
    required this.wakeTime,
    required this.hoursSlept,
    required this.notes,
  });

  Map<String, Object> toMap() {
    return {
      'userId': userId,
      'sleepDate': sleepDate,
      'bedTime': bedTime,
      'wakeTime': wakeTime,
      'hoursSlept': hoursSlept,
      'notes': notes,
    };
  }

  factory SleepRecord.fromMap(Map<String, dynamic> map, String id) {
    return SleepRecord(
      id: id,
      userId: map['userId'] ?? '',
      sleepDate: map['sleepDate'] ?? '',
      bedTime: map['bedTime'] ?? '',
      wakeTime: map['wakeTime'] ?? '',
      hoursSlept: map['hoursSlept']?.toInt() ?? 0,
      notes: map['notes'] ?? '',
    );
  }
}
