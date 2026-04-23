class UserModel {
  final String id;
  final String name;
  final String email;
  final String status; // Active, Inactive
  final String plan; // Free, Premium
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.plan,
    required this.createdAt,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status,
      'plan': plan,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      plan: json['plan'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Copy with
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? status,
    String? plan,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      plan: plan ?? this.plan,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
