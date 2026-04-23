# Setup Commands

## Install Dependencies
```bash
flutter pub get
```

## Run the App
```bash
flutter run
```

## Clean Build (if needed)
```bash
flutter clean
flutter pub get
flutter run
```

## Build APK (Android)
```bash
flutter build apk --release
```

## Build for iOS
```bash
flutter build ios --release
```

## Check for Issues
```bash
flutter doctor
```

## Format Code
```bash
flutter format .
```

## Analyze Code
```bash
flutter analyze
```

---

## Quick Test Checklist

### ✅ Auto-Login Test
1. Register with email/password
2. Close app completely
3. Reopen app
4. Should go directly to dashboard (no login screen)

### ✅ Permission Test
1. Go to Notifications screen
2. Should show permission dialog (first time only)
3. Go to Add Alarm screen
4. Should show alarm permission dialog (first time only)

### ✅ Language Change Test
1. Go to Profile screen
2. Click on "Language"
3. Select "हिंदी (Hindi)"
4. App should change to Hindi instantly
5. Change back to English

### ✅ User Management Test (Admin)
1. Navigate to `/admin_dashboard`
2. Go to User Management
3. Click + button to add user
4. Fill details and save
5. Edit a user
6. Delete a user (with confirmation)
7. Search for users

### ✅ Responsive Test
1. Run on different screen sizes
2. Check tablet mode
3. Check landscape orientation
4. All elements should scale properly

### ✅ Logout Test
1. Go to Profile
2. Click Logout
3. Confirm logout
4. Should go to login screen
5. Login state should be cleared

---

## Common Issues & Solutions

### Issue: Permission handler not working
**Solution:**
```bash
flutter clean
flutter pub get
cd android
./gradlew clean
cd ..
flutter run
```

### Issue: ScreenUtil not working
**Solution:**
Make sure ScreenUtilInit is wrapping MaterialApp in main.dart

### Issue: Localization not working
**Solution:**
Check that flutter_localizations is added in pubspec.yaml

### Issue: SharedPreferences not saving
**Solution:**
```bash
flutter clean
flutter pub get
```

---

## File Structure

```
lib/
├── l10n/                    # Localization files
│   ├── app_en.dart         # English translations
│   └── app_hi.dart         # Hindi translations
├── models/                  # Data models
│   └── user_model.dart     # User model
├── screens/                 # All screens
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── dashboard_screen.dart
│   ├── profile_screen.dart
│   ├── blog_screen.dart
│   ├── challenges_screen.dart
│   ├── leaderboard_screen.dart
│   ├── admin_dashboard_screen.dart
│   ├── user_management_screen.dart
│   ├── data_management_screen.dart
│   └── audit_logs_screen.dart
├── services/                # Business logic
│   ├── auth_service.dart   # Authentication
│   ├── permission_service.dart # Permissions
│   ├── localization_service.dart # Languages
│   └── user_service.dart   # User CRUD
├── theme/                   # App theme
│   └── theme.dart
├── widgets/                 # Reusable widgets
│   ├── custom_button.dart
│   ├── custom_textfield.dart
│   └── app_logo.dart
├── globals.dart            # Global variables
└── main.dart               # App entry point
```

---

## Testing Routes

You can test different screens directly by navigating to these routes:

```dart
Navigator.pushNamed(context, '/login');
Navigator.pushNamed(context, '/register');
Navigator.pushNamed(context, '/home');
Navigator.pushNamed(context, '/blog');
Navigator.pushNamed(context, '/services');
Navigator.pushNamed(context, '/challenges');
Navigator.pushNamed(context, '/leaderboard');
Navigator.pushNamed(context, '/change_password');
Navigator.pushNamed(context, '/admin_dashboard');
```

---

## Environment

- Flutter SDK: >=3.1.3 <4.0.0
- Dart SDK: >=3.1.3 <4.0.0
- Android: minSdkVersion 21
- iOS: iOS 12.0+
