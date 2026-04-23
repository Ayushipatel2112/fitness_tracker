import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout_model.dart';
import 'api_service.dart';

// ─── WorkoutService ───────────────────────────────────────────────────
// Handles all CRUD operations for workouts.
//
// CRUD = Create, Read, Update, Delete
// Each method either:
//   1. Calls the real API (when backend is connected)
//   2. Falls back to local storage (SharedPreferences) for offline use
// ─────────────────────────────────────────────────────────────────────

class WorkoutService {
  // Key used to store workouts in local storage
  static const String _key = 'workouts';

  // ── GET all workouts ─────────────────────────────────────────────
  // Tries API first, if unavailable uses local storage
  static Future<List<WorkoutModel>> getWorkouts() async {
    try {
      // API call: GET /workouts
      final response = await ApiService.get('/workouts');

      // If API returned an error, load from local storage instead
      if (response.containsKey('error')) {
        return _getLocalWorkouts();
      }

      // Convert API response list to WorkoutModel list
      final List<dynamic> list = response['data'] ?? [];
      return list.map((item) => WorkoutModel.fromJson(item)).toList();
    } catch (e) {
      // If anything goes wrong, use local storage
      return _getLocalWorkouts();
    }
  }

  // ── ADD a new workout ────────────────────────────────────────────
  static Future<bool> addWorkout(WorkoutModel workout) async {
    try {
      // API call: POST /workout
      final response = await ApiService.post('/workout', workout.toJson());

      if (response.containsKey('error')) {
        // Save locally if API fails
        return _saveLocalWorkout(workout);
      }
      return true; // success
    } catch (e) {
      return _saveLocalWorkout(workout);
    }
  }

  // ── UPDATE an existing workout ───────────────────────────────────
  static Future<bool> updateWorkout(WorkoutModel workout) async {
    try {
      // API call: PUT /workout/{id}
      final response = await ApiService.put('/workout/${workout.id}', workout.toJson());

      if (response.containsKey('error')) {
        return _updateLocalWorkout(workout);
      }
      return true;
    } catch (e) {
      return _updateLocalWorkout(workout);
    }
  }

  // ── DELETE a workout ─────────────────────────────────────────────
  static Future<bool> deleteWorkout(String id) async {
    try {
      // API call: DELETE /workout/{id}
      final response = await ApiService.delete('/workout/$id');

      if (response.containsKey('error')) {
        return _deleteLocalWorkout(id);
      }
      return true;
    } catch (e) {
      return _deleteLocalWorkout(id);
    }
  }

  // ── LOCAL STORAGE HELPERS ────────────────────────────────────────
  // These methods save/read workouts from the device when offline

  static Future<List<WorkoutModel>> _getLocalWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return []; // no data
    final List<dynamic> list = jsonDecode(json);
    return list.map((item) => WorkoutModel.fromJson(item)).toList();
  }

  static Future<bool> _saveLocalWorkout(WorkoutModel workout) async {
    final workouts = await _getLocalWorkouts();
    workouts.add(workout);
    return _saveAllLocal(workouts);
  }

  static Future<bool> _updateLocalWorkout(WorkoutModel updated) async {
    final workouts = await _getLocalWorkouts();
    final index = workouts.indexWhere((w) => w.id == updated.id);
    if (index != -1) workouts[index] = updated;
    return _saveAllLocal(workouts);
  }

  static Future<bool> _deleteLocalWorkout(String id) async {
    final workouts = await _getLocalWorkouts();
    workouts.removeWhere((w) => w.id == id);
    return _saveAllLocal(workouts);
  }

  static Future<bool> _saveAllLocal(List<WorkoutModel> workouts) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(workouts.map((w) => w.toJson()).toList());
    return prefs.setString(_key, json);
  }
}
