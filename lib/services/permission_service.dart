import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionService {
  static const String _keyNotificationAsked = 'notificationPermissionAsked';
  static const String _keyAlarmAsked = 'alarmPermissionAsked';

  // Check if notification permission was already asked
  static Future<bool> wasNotificationPermissionAsked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotificationAsked) ?? false;
  }

  // Check if alarm permission was already asked
  static Future<bool> wasAlarmPermissionAsked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAlarmAsked) ?? false;
  }

  // Request notification permission (only once)
  static Future<bool> requestNotificationPermission() async {
    final wasAsked = await wasNotificationPermissionAsked();
    
    if (wasAsked) {
      // Already asked, just check current status
      return await Permission.notification.isGranted;
    }

    // First time asking
    final status = await Permission.notification.request();
    
    // Mark as asked
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotificationAsked, true);
    
    return status.isGranted;
  }

  // Request alarm permission (only once)
  static Future<bool> requestAlarmPermission() async {
    final wasAsked = await wasAlarmPermissionAsked();
    
    if (wasAsked) {
      // Already asked, just check current status
      return await Permission.scheduleExactAlarm.isGranted;
    }

    // First time asking
    final status = await Permission.scheduleExactAlarm.request();
    
    // Mark as asked
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAlarmAsked, true);
    
    return status.isGranted;
  }

  // Check notification permission status
  static Future<bool> hasNotificationPermission() async {
    return await Permission.notification.isGranted;
  }

  // Check alarm permission status
  static Future<bool> hasAlarmPermission() async {
    return await Permission.scheduleExactAlarm.isGranted;
  }

  // Open app settings
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
