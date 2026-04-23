# 🗺️ Complete Navigation Guide - Fitness Tracker App

## 📍 Newly Added Screens Location

### 1. **Blog Screens** (Guest Pages)
**Location:** `lib/screens/`
- `blog_screen.dart` - Main blog listing page
- `blog_article_screen.dart` - Individual article view

**How to Access:**
```dart
// From any screen
Navigator.pushNamed(context, '/blog');

// Or directly
Navigator.push(context, MaterialPageRoute(
  builder: (context) => const BlogScreen()
));
```

**UI Flow:**
```
Welcome Screen → Blog (bottom link/menu)
Blog Screen → Click Article → Blog Article Screen
```

---

### 2. **Services Screen** (Guest Page)
**Location:** `lib/screens/services_screen.dart`

**How to Access:**
```dart
Navigator.pushNamed(context, '/services');
```

**UI Flow:**
```
Welcome Screen → Services Button
Login Screen → Services Link
```

---

### 3. **Change Password Screen** (User Page)
**Location:** `lib/screens/change_password_screen.dart`

**How to Access:**
```dart
Navigator.pushNamed(context, '/change_password');

// Or from Profile/Settings
Navigator.push(context, MaterialPageRoute(
  builder: (context) => const ChangePasswordScreen()
));
```

**UI Flow:**
```
Dashboard → Profile → Settings → Change Password
```

---

### 4. **Challenges Screen** (User Page)
**Location:** `lib/screens/challenges_screen.dart`

**How to Access:**
```dart
Navigator.pushNamed(context, '/challenges');
```

**Features:**
- Active Challenges tab
- Completed Challenges tab
- Join new challenges
- Track progress

**UI Flow:**
```
Dashboard → Home → Challenges Card
Dashboard → Bottom Menu → Challenges
```

---

### 5. **Leaderboard Screen** (User Page)
**Location:** `lib/screens/leaderboard_screen.dart`

**How to Access:**
```dart
Navigator.pushNamed(context, '/leaderboard');
```

**Features:**
- Weekly/Monthly/All Time rankings
- Top 3 podium display
- User rankings list
- Points system

**UI Flow:**
```
Dashboard → Home → Leaderboard Card
Challenges Screen → View Leaderboard
```

---

### 6. **Admin Dashboard** (Admin Page)
**Location:** `lib/screens/admin_dashboard_screen.dart`

**How to Access:**
```dart
Navigator.pushNamed(context, '/admin_dashboard');
```

**Features:**
- User statistics
- Activity graphs
- Quick actions
- Recent activity feed

**UI Flow:**
```
Profile → Settings → Admin Panel (if admin)
Direct route: /admin_dashboard
```

---

### 7. **User Management Screen** (Admin Page)
**Location:** `lib/screens/user_management_screen.dart`

**How to Access:**
```dart
// From Admin Dashboard
Navigator.push(context, MaterialPageRoute(
  builder: (context) => const UserManagementScreen()
));
```

**Features:**
- ✅ Add new users
- ✅ Edit user details
- ✅ Delete users
- ✅ Search users
- ✅ View user stats

**UI Flow:**
```
Admin Dashboard → User Management Card
```

---

### 8. **Data Management Screen** (Admin Page)
**Location:** `lib/screens/data_management_screen.dart`

**How to Access:**
```dart
// From Admin Dashboard
Navigator.push(context, MaterialPageRoute(
  builder: (context) => const DataManagementScreen()
));
```

**Features:**
- Database backup
- Export data
- Import data
- Storage info
- Clean old data

**UI Flow:**
```
Admin Dashboard → Data Management Card
```

---

### 9. **Audit Logs Screen** (Admin Page)
**Location:** `lib/screens/audit_logs_screen.dart`

**How to Access:**
```dart
// From Admin Dashboard
Navigator.push(context, MaterialPageRoute(
  builder: (context) => const AuditLogsScreen()
));
```

**Features:**
- Activity logs
- Filter by type (User/Admin/System/Error)
- Export logs
- Timestamp tracking

**UI Flow:**
```
Admin Dashboard → Audit Logs Card
```

---

## 🔗 All Routes in main.dart

```dart
routes: {
  '/': (context) => const SplashScreen(),
  '/welcome': (context) => const WelcomeScreen(),
  '/intro1': (context) => const Intro1Screen(),
  '/intro2': (context) => const Intro2Screen(),
  '/intro3': (context) => const Intro3Screen(),
  '/intro4': (context) => const Intro4Screen(),
  '/register': (context) => const RegisterScreen(),
  '/gender_selection': (context) => const GenderSelectionScreen(),
  '/profile_info': (context) => const ProfileInfoScreen(),
  '/goal_selection': (context) => const GoalSelectionScreen(),
  '/login': (context) => const LoginScreen(),
  '/success': (context) => const SuccessScreen(),
  '/home': (context) => DashboardScreen(...),
  
  // NEW ROUTES
  '/blog': (context) => const BlogScreen(),
  '/services': (context) => const ServicesScreen(),
  '/change_password': (context) => const ChangePasswordScreen(),
  '/challenges': (context) => const ChallengesScreen(),
  '/leaderboard': (context) => const LeaderboardScreen(),
  '/admin_dashboard': (context) => const AdminDashboardScreen(),
}
```

---

## 📱 Complete App Flow

### Guest User Flow (Not Logged In)
```
Splash Screen
    ↓
Welcome Screen
    ↓
┌─────────────────────────────────┐
│ • Login                         │
│ • Register                      │
│ • Blog (NEW)                    │
│ • Services (NEW)                │
│ • Contact                       │
└─────────────────────────────────┘
```

### Logged In User Flow
```
Splash Screen (Auto-login check)
    ↓
Dashboard (Home)
    ↓
┌─────────────────────────────────────────┐
│ Bottom Navigation:                      │
│ • Home                                  │
│ • Workout Tracker                       │
│ • Meal Tracker                          │
│ • Sleep Tracker                         │
│ • Profile                               │
└─────────────────────────────────────────┘
    ↓
From Home:
    • Activity Tracker
    • Progress Photo
    • Notifications
    • Challenges (NEW)
    • Leaderboard (NEW)
    
From Profile:
    • Personal Data
    • Achievement
    • Workout Progress
    • Settings
        ↓ Change Password (NEW)
        ↓ Language (NEW)
    • Contact Us
    • Privacy Policy
    • Logout
```

### Admin User Flow
```
Dashboard
    ↓
Profile → Settings → Admin Panel
    ↓
Admin Dashboard (NEW)
    ↓
┌─────────────────────────────────┐
│ • User Management (NEW)         │
│   - Add User                    │
│   - Edit User                   │
│   - Delete User                 │
│   - Search Users                │
│                                 │
│ • Data Management (NEW)         │
│   - Backup                      │
│   - Export                      │
│   - Import                      │
│   - Clean Data                  │
│                                 │
│ • Audit Logs (NEW)              │
│   - View Logs                   │
│   - Filter Logs                 │
│   - Export Logs                 │
│                                 │
│ • Reports                       │
└─────────────────────────────────┘
```

---

## 🎯 Quick Access Examples

### Example 1: Access Blog from Welcome Screen
```dart
// In welcome_screen.dart, add a button:
ElevatedButton(
  onPressed: () => Navigator.pushNamed(context, '/blog'),
  child: const Text('Read Blog'),
)
```

### Example 2: Access Challenges from Home
```dart
// In home_screen.dart, add a card:
GestureDetector(
  onTap: () => Navigator.pushNamed(context, '/challenges'),
  child: _challengeCard(),
)
```

### Example 3: Access Admin Dashboard
```dart
// In profile_screen.dart or settings:
ListTile(
  leading: const Icon(Icons.admin_panel_settings),
  title: const Text('Admin Panel'),
  onTap: () => Navigator.pushNamed(context, '/admin_dashboard'),
)
```

### Example 4: Language Change
```dart
// Already implemented in profile_screen.dart
// Profile → Language → Select English/Hindi
```

---

## 📂 File Structure Summary

```
lib/
├── screens/
│   ├── blog_screen.dart              ✅ NEW
│   ├── blog_article_screen.dart      ✅ NEW
│   ├── services_screen.dart          ✅ NEW
│   ├── challenges_screen.dart        ✅ NEW
│   ├── leaderboard_screen.dart       ✅ NEW
│   ├── change_password_screen.dart   ✅ NEW
│   ├── admin_dashboard_screen.dart   ✅ NEW
│   ├── user_management_screen.dart   ✅ NEW
│   ├── data_management_screen.dart   ✅ NEW
│   ├── audit_logs_screen.dart        ✅ NEW
│   └── ... (existing screens)
│
├── services/
│   ├── auth_service.dart             ✅ NEW (Auto-login)
│   ├── permission_service.dart       ✅ NEW (Permissions)
│   ├── localization_service.dart     ✅ NEW (Languages)
│   └── user_service.dart             ✅ NEW (User CRUD)
│
├── models/
│   └── user_model.dart               ✅ NEW
│
├── l10n/
│   ├── app_en.dart                   ✅ NEW (English)
│   └── app_hi.dart                   ✅ NEW (Hindi)
│
└── main.dart                         ✅ UPDATED (Routes + Localization)
```

---

## 🧪 Testing Each Screen

### Test Blog:
```dart
// Run app and navigate:
Welcome → Blog Button → Blog Screen → Click Article
```

### Test Services:
```dart
// Run app and navigate:
Welcome → Services Button → Services Screen
```

### Test Challenges:
```dart
// Login first, then:
Dashboard → Home → Challenges Card
```

### Test Leaderboard:
```dart
// Login first, then:
Dashboard → Home → Leaderboard Card
```

### Test Admin Features:
```dart
// Login first, then:
Profile → Settings → Admin Panel → Admin Dashboard
→ User Management (Add/Edit/Delete users)
→ Data Management (Backup/Export)
→ Audit Logs (View logs)
```

### Test Language Change:
```dart
// Login first, then:
Profile → Language → Select Hindi/English
```

### Test Auto-Login:
```dart
1. Login with any credentials
2. Close app completely
3. Reopen app
4. Should go directly to Dashboard (no login screen)
```

---

## 💡 Tips

1. **All routes are registered in `main.dart`**
2. **Use `Navigator.pushNamed(context, '/route_name')` for navigation**
3. **Admin screens accessible from Admin Dashboard**
4. **Language changes instantly (no restart needed)**
5. **Auto-login works after first login/register**
6. **Permissions asked only once**

---

## 🔍 Finding Screens in Code

All screens are in: `lib/screens/`

Search by name:
- Blog: `blog_screen.dart`
- Services: `services_screen.dart`
- Challenges: `challenges_screen.dart`
- Leaderboard: `leaderboard_screen.dart`
- Admin: `admin_dashboard_screen.dart`
- User Management: `user_management_screen.dart`
- Data Management: `data_management_screen.dart`
- Audit Logs: `audit_logs_screen.dart`
