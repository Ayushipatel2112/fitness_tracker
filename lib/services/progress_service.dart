import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/progress_model.dart';
import 'api_service.dart';

// ─── ProgressService ──────────────────────────────────────────────────
// Handles user weight/progress tracking.
// API-first with local storage fallback.
// ─────────────────────────────────────────────────────────────────────

class ProgressService {
  static const String _key = 'progress_logs';

  // ── GET all progress entries ─────────────────────────────────────
  static Future<List<ProgressModel>> getProgress() async {
    try {
      final response = await ApiService.get('/progress');
      if (response.containsKey('error')) return _getLocalProgress();

      final List<dynamic> list = response['data'] ?? [];
      return list.map((item) => ProgressModel.fromJson(item)).toList();
    } catch (e) {
      return _getLocalProgress();
    }
  }

  // ── LOG a new weight entry ───────────────────────────────────────
  static Future<bool> logProgress(ProgressModel progress) async {
    try {
      final response = await ApiService.post('/progress', progress.toJson());
      if (response.containsKey('error')) return _saveLocalProgress(progress);
      return true;
    } catch (e) {
      return _saveLocalProgress(progress);
    }
  }

  // ── Get latest weight ────────────────────────────────────────────
  static Future<double> getLatestWeight() async {
    final logs = await getProgress();
    if (logs.isEmpty) return 0;
    // Sort by date descending and get the first (most recent)
    logs.sort((a, b) => b.date.compareTo(a.date));
    return logs.first.weight;
  }

  // ── LOCAL STORAGE HELPERS ────────────────────────────────────────

  static Future<List<ProgressModel>> _getLocalProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return [];
    final List<dynamic> list = jsonDecode(json);
    return list.map((item) => ProgressModel.fromJson(item)).toList();
  }

  static Future<bool> _saveLocalProgress(ProgressModel progress) async {
    final logs = await _getLocalProgress();
    logs.add(progress);
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(logs.map((p) => p.toJson()).toList());
    return prefs.setString(_key, json);
  }
}
