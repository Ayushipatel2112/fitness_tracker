import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sleep_model.dart';
import 'api_service.dart';

// ─── SleepService ─────────────────────────────────────────────────────
// Handles logging and reading sleep data.
// API-first with local storage fallback.
// ─────────────────────────────────────────────────────────────────────

class SleepService {
  static const String _key = 'sleep_logs';

  // ── GET all sleep logs ───────────────────────────────────────────
  static Future<List<SleepModel>> getSleepLogs() async {
    try {
      final response = await ApiService.get('/sleep');
      if (response.containsKey('error')) return _getLocalSleep();

      final List<dynamic> list = response['data'] ?? [];
      return list.map((item) => SleepModel.fromJson(item)).toList();
    } catch (e) {
      return _getLocalSleep();
    }
  }

  // ── LOG new sleep entry ──────────────────────────────────────────
  static Future<bool> logSleep(SleepModel sleep) async {
    try {
      final response = await ApiService.post('/sleep', sleep.toJson());
      if (response.containsKey('error')) return _saveLocalSleep(sleep);
      return true;
    } catch (e) {
      return _saveLocalSleep(sleep);
    }
  }

  // ── Get average sleep hours for the last 7 days ──────────────────
  static Future<double> getAverageSleep() async {
    final logs = await getSleepLogs();
    if (logs.isEmpty) return 0;

    // Filter last 7 days
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final recent = logs.where((s) => s.date.isAfter(sevenDaysAgo)).toList();
    if (recent.isEmpty) return 0;

    // Calculate average
    final total = recent.fold(0.0, (sum, s) => sum + s.hours);
    return total / recent.length;
  }

  // ── LOCAL STORAGE HELPERS ────────────────────────────────────────

  static Future<List<SleepModel>> _getLocalSleep() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return [];
    final List<dynamic> list = jsonDecode(json);
    return list.map((item) => SleepModel.fromJson(item)).toList();
  }

  static Future<bool> _saveLocalSleep(SleepModel sleep) async {
    final logs = await _getLocalSleep();
    logs.add(sleep);
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(logs.map((s) => s.toJson()).toList());
    return prefs.setString(_key, json);
  }
}
