import 'package:shared_preferences/shared_preferences.dart';

// ─── AuthService ─────────────────────────────────────────────────────
// Handles login, logout, and checking if the user is logged in.
// Uses SharedPreferences (local storage) to save the session on the device.
//
// SharedPreferences works like a simple key-value store:
//   prefs.setString('key', 'value')  → save
//   prefs.getString('key')            → read
//   prefs.clear()                     → delete all
// ─────────────────────────────────────────────────────────────────────

class AuthService {
  // Keys used to store data in local storage
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserName   = 'userName';
  static const String _keyUserEmail  = 'userEmail';
  static const String _keyUserRole   = 'userRole'; // 'user' or 'admin'

  // ── Check if user is already logged in ──────────────────────────
  // Called on app start (SplashScreen) to auto-login if token exists.
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false; // returns false if not found
  }

  // ── Login: save user session to local storage ────────────────────
  // Called after successful login/register.
  // role = 'user' for normal users, 'admin' for admins
  static Future<void> login({
    required String name,
    required String email,
    String role = 'user',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserRole, role);
  }

  // ── Logout: clear all saved session data ────────────────────────
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // removes everything
  }

  // ── Get saved user name ──────────────────────────────────────────
  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName) ?? 'User';
  }

  // ── Get saved user email ─────────────────────────────────────────
  static Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail) ?? '';
  }

  // ── Get saved user role ──────────────────────────────────────────
  // Returns 'user' or 'admin'
  static Future<String> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserRole) ?? 'user';
  }
}
