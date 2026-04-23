import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_en.dart';
import '../l10n/app_hi.dart';

class LocalizationService {
  static const String _keyLanguage = 'app_language';
  
  // Get saved language
  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_keyLanguage) ?? 'en';
    return Locale(languageCode);
  }
  
  // Save language
  static Future<void> saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, languageCode);
  }
  
  // Get translations
  static Map<String, String> getTranslations(String languageCode) {
    switch (languageCode) {
      case 'hi':
        return AppLocalizationsHi.values;
      case 'en':
      default:
        return AppLocalizationsEn.values;
    }
  }
}

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalizations(this.locale) {
    _localizedStrings = LocalizationService.getTranslations(locale.languageCode);
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
  
  String get appName => translate('app_name');
  String get welcome => translate('welcome');
  String get login => translate('login');
  String get register => translate('register');
  String get logout => translate('logout');
  String get cancel => translate('cancel');
  String get save => translate('save');
  String get delete => translate('delete');
  String get edit => translate('edit');
  String get add => translate('add');
  String get update => translate('update');
  String get confirm => translate('confirm');
  String get yes => translate('yes');
  String get no => translate('no');
  
  String get email => translate('email');
  String get password => translate('password');
  String get firstName => translate('first_name');
  String get lastName => translate('last_name');
  String get forgotPassword => translate('forgot_password');
  String get dontHaveAccount => translate('dont_have_account');
  String get alreadyHaveAccount => translate('already_have_account');
  String get createAccount => translate('create_account');
  String get welcomeBack => translate('welcome_back');
  
  String get dashboard => translate('dashboard');
  String get home => translate('home');
  String get profile => translate('profile');
  String get settings => translate('settings');
  String get notifications => translate('notifications');
  
  String get workout => translate('workout');
  String get workoutTracker => translate('workout_tracker');
  String get workoutProgress => translate('workout_progress');
  String get exercises => translate('exercises');
  String get caloriesBurned => translate('calories_burned');
  
  String get mealPlanner => translate('meal_planner');
  String get mealTracker => translate('meal_tracker');
  String get breakfast => translate('breakfast');
  String get lunch => translate('lunch');
  String get dinner => translate('dinner');
  String get snacks => translate('snacks');
  
  String get sleepTracker => translate('sleep_tracker');
  String get sleepSchedule => translate('sleep_schedule');
  String get hoursOfSleep => translate('hours_of_sleep');
  
  String get progress => translate('progress');
  String get progressTracker => translate('progress_tracker');
  String get weight => translate('weight');
  String get height => translate('height');
  String get age => translate('age');
  
  String get challenges => translate('challenges');
  String get leaderboard => translate('leaderboard');
  String get achievements => translate('achievements');
  
  String get changePassword => translate('change_password');
  String get language => translate('language');
  String get privacyPolicy => translate('privacy_policy');
  String get contactUs => translate('contact_us');
  
  String get logoutConfirm => translate('logout_confirm');
  String get deleteConfirm => translate('delete_confirm');
  String get success => translate('success');
  String get error => translate('error');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
