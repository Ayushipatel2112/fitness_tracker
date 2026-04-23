import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ─── ApiService ──────────────────────────────────────────────────────
// This file handles all HTTP API calls (GET, POST, PUT, DELETE).
//
// How HTTP requests work:
//   GET    → Read data from server
//   POST   → Send new data to server
//   PUT    → Update existing data on server
//   DELETE → Remove data from server
//
// IMPORTANT: Replace 'YOUR_API_BASE_URL' below with your actual server URL.
// Example: 'https://myfitnessapi.com/api'
// ─────────────────────────────────────────────────────────────────────

class ApiService {
  // ── Base URL of your backend server ─────────────────────────────
  // Change this to match your actual API URL
  static const String baseUrl = 'https://YOUR_API_BASE_URL/api';

  // ── Get the saved login token from local storage ─────────────────
  // Token is sent with every request to prove the user is logged in
  static Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  // ── Build request headers ────────────────────────────────────────
  // Headers tell the server: "I'm logged in, here is my token"
  static Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json', // sending JSON data
      'Authorization': 'Bearer $token',   // attach login token
    };
  }

  // ── GET request: read data from server ──────────────────────────
  // endpoint example: '/workouts'
  // Returns the response body as a Map (key-value pairs)
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      // If there's a network error, return an error map
      return {'error': 'Network error: $e'};
    }
  }

  // ── POST request: send new data to server ───────────────────────
  // endpoint example: '/workout'
  // body example: {'name': 'Running', 'duration': 30, 'calories': 200}
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body), // convert Map to JSON string
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }

  // ── PUT request: update existing data on server ─────────────────
  // endpoint example: '/workout/123'
  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }

  // ── DELETE request: remove data from server ──────────────────────
  // endpoint example: '/workout/123'
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }

  // ── Handle response from server ──────────────────────────────────
  // Checks the status code and converts response to a Map
  // Status 200-299 = success, anything else = error
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Success: decode the JSON response body
      return jsonDecode(response.body);
    } else {
      // Error: return the error message from server
      return {
        'error': 'Server error ${response.statusCode}',
        'message': response.body,
      };
    }
  }

  // ── LOGIN API call ───────────────────────────────────────────────
  // POST /login with email and password
  // Returns token and user role on success
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }

  // ── REGISTER API call ────────────────────────────────────────────
  // POST /register with user details
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }

  // ── FORGOT PASSWORD API call ─────────────────────────────────────
  // POST /forgot-password with email
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }
}
