import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';
import 'api_service.dart';

// ─── MealService ──────────────────────────────────────────────────────
// Handles all CRUD operations for meal tracking.
// API-first with local storage fallback.
// ─────────────────────────────────────────────────────────────────────

class MealService {
  static const String _key = 'meals';

  // ── GET all meals ────────────────────────────────────────────────
  static Future<List<MealModel>> getMeals() async {
    try {
      final response = await ApiService.get('/meals');
      if (response.containsKey('error')) return _getLocalMeals();

      final List<dynamic> list = response['data'] ?? [];
      return list.map((item) => MealModel.fromJson(item)).toList();
    } catch (e) {
      return _getLocalMeals();
    }
  }

  // ── GET meals by type (Breakfast, Lunch, Dinner) ─────────────────
  static Future<List<MealModel>> getMealsByType(String type) async {
    final allMeals = await getMeals();
    return allMeals.where((meal) => meal.type == type).toList();
  }

  // ── ADD a new meal ───────────────────────────────────────────────
  static Future<bool> addMeal(MealModel meal) async {
    try {
      final response = await ApiService.post('/meal', meal.toJson());
      if (response.containsKey('error')) return _saveLocalMeal(meal);
      return true;
    } catch (e) {
      return _saveLocalMeal(meal);
    }
  }

  // ── UPDATE a meal ────────────────────────────────────────────────
  static Future<bool> updateMeal(MealModel meal) async {
    try {
      final response = await ApiService.put('/meal/${meal.id}', meal.toJson());
      if (response.containsKey('error')) return _updateLocalMeal(meal);
      return true;
    } catch (e) {
      return _updateLocalMeal(meal);
    }
  }

  // ── DELETE a meal ────────────────────────────────────────────────
  static Future<bool> deleteMeal(String id) async {
    try {
      final response = await ApiService.delete('/meal/$id');
      if (response.containsKey('error')) return _deleteLocalMeal(id);
      return true;
    } catch (e) {
      return _deleteLocalMeal(id);
    }
  }

  // ── Get total calories for today ─────────────────────────────────
  static Future<int> getTodayCalories() async {
    final meals = await getMeals();
    final today = DateTime.now();
    final todayMeals = meals.where((m) =>
      m.date.year == today.year &&
      m.date.month == today.month &&
      m.date.day == today.day
    ).toList();
    return todayMeals.fold<int>(0, (sum, m) => sum + m.calories);
  }

  // ── LOCAL STORAGE HELPERS ────────────────────────────────────────

  static Future<List<MealModel>> _getLocalMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return [];
    final List<dynamic> list = jsonDecode(json);
    return list.map((item) => MealModel.fromJson(item)).toList();
  }

  static Future<bool> _saveLocalMeal(MealModel meal) async {
    final meals = await _getLocalMeals();
    meals.add(meal);
    return _saveAllLocal(meals);
  }

  static Future<bool> _updateLocalMeal(MealModel updated) async {
    final meals = await _getLocalMeals();
    final index = meals.indexWhere((m) => m.id == updated.id);
    if (index != -1) meals[index] = updated;
    return _saveAllLocal(meals);
  }

  static Future<bool> _deleteLocalMeal(String id) async {
    final meals = await _getLocalMeals();
    meals.removeWhere((m) => m.id == id);
    return _saveAllLocal(meals);
  }

  static Future<bool> _saveAllLocal(List<MealModel> meals) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(meals.map((m) => m.toJson()).toList());
    return prefs.setString(_key, json);
  }
}
