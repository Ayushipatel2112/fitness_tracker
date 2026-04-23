import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserService {
  static const String _keyUsers = 'app_users';

  // Get all users
  static Future<List<UserModel>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_keyUsers);
    
    if (usersJson == null) {
      // Return demo users if no data
      return _getDemoUsers();
    }
    
    final List<dynamic> usersList = json.decode(usersJson);
    return usersList.map((json) => UserModel.fromJson(json)).toList();
  }

  // Add user
  static Future<void> addUser(UserModel user) async {
    final users = await getAllUsers();
    users.add(user);
    await _saveUsers(users);
  }

  // Update user
  static Future<void> updateUser(UserModel updatedUser) async {
    final users = await getAllUsers();
    final index = users.indexWhere((u) => u.id == updatedUser.id);
    
    if (index != -1) {
      users[index] = updatedUser;
      await _saveUsers(users);
    }
  }

  // Delete user
  static Future<void> deleteUser(String userId) async {
    final users = await getAllUsers();
    users.removeWhere((u) => u.id == userId);
    await _saveUsers(users);
  }

  // Get user by ID
  static Future<UserModel?> getUserById(String userId) async {
    final users = await getAllUsers();
    try {
      return users.firstWhere((u) => u.id == userId);
    } catch (e) {
      return null;
    }
  }

  // Search users
  static Future<List<UserModel>> searchUsers(String query) async {
    final users = await getAllUsers();
    if (query.isEmpty) return users;
    
    return users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) ||
             user.email.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Save users to storage
  static Future<void> _saveUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = json.encode(users.map((u) => u.toJson()).toList());
    await prefs.setString(_keyUsers, usersJson);
  }

  // Demo users
  static List<UserModel> _getDemoUsers() {
    return [
      UserModel(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@email.com',
        status: 'Active',
        plan: 'Premium',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      UserModel(
        id: '2',
        name: 'Sarah Smith',
        email: 'sarah.smith@email.com',
        status: 'Active',
        plan: 'Free',
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
      ),
      UserModel(
        id: '3',
        name: 'Mike Johnson',
        email: 'mike.j@email.com',
        status: 'Inactive',
        plan: 'Premium',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      UserModel(
        id: '4',
        name: 'Emma Wilson',
        email: 'emma.w@email.com',
        status: 'Active',
        plan: 'Premium',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      UserModel(
        id: '5',
        name: 'David Lee',
        email: 'david.lee@email.com',
        status: 'Active',
        plan: 'Free',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }
}
