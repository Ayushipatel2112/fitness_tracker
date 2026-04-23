# 📍 Screens Location & Access Guide

## ✅ Newly Added Screens (9 Total)

### 1️⃣ Blog Screen
- **File:** `lib/screens/blog_screen.dart`
- **Route:** `/blog`
- **Access:** `Navigator.pushNamed(context, '/blog')`
- **Type:** Guest Page
- **Features:** Article listing, search, categories

### 2️⃣ Blog Article Screen
- **File:** `lib/screens/blog_article_screen.dart`
- **Route:** Direct navigation from Blog Screen
- **Access:** `Navigator.push(context, MaterialPageRoute(builder: (c) => BlogArticleScreen()))`
- **Type:** Guest Page
- **Features:** Full article view, related articles

### 3️⃣ Services Screen
- **File:** `lib/screens/services_screen.dart`
- **Route:** `/services`
- **Access:** `Navigator.pushNamed(context, '/services')`
- **Type:** Guest Page
- **Features:** App services showcase

### 4️⃣ Change Password Screen
- **File:** `lib/screens/change_password_screen.dart`
- **Route:** `/change_password`
- **Access:** `Navigator.pushNamed(context, '/change_password')`
- **Type:** User Page
- **Features:** Password update with validation

### 5️⃣ Challenges Screen
- **File:** `lib/screens/challenges_screen.dart`
- **Route:** `/challenges`
- **Access:** `Navigator.pushNamed(context, '/challenges')`
- **Type:** User Page
- **Features:** Active/Completed challenges, join challenges

### 6️⃣ Leaderboard Screen
- **File:** `lib/screens/leaderboard_screen.dart`
- **Route:** `/leaderboard`
- **Access:** `Navigator.pushNamed(context, '/leaderboard')`
- **Type:** User Page
- **Features:** Rankings, podium, weekly/monthly/all-time

### 7️⃣ Admin Dashboard Screen
- **File:** `lib/screens/admin_dashboard_screen.dart`
- **Route:** `/admin_dashboard`
- **Access:** `Navigator.pushNamed(context, '/admin_dashboard')`
- **Type:** Admin Page
- **Features:** Stats, quick actions, user growth chart

### 8️⃣ User Management Screen
- **File:** `lib/screens/user_management_screen.dart`
- **Route:** From Admin Dashboard
- **Access:** `Navigator.push(context, MaterialPageRoute(builder: (c) => UserManagementScreen()))`
- **Type:** Admin Page
- **Features:** ✅ Add, ✅ Edit, ✅ Delete, ✅ Search users

### 9️⃣ Data Management Screen
- **File:** `lib/screens/data_management_screen.dart`
- **Route:** From Admin Dashboard
- **Access:** `Navigator.push(context, MaterialPageRoute(builder: (c) => DataManagementScreen()))`
- **Type:** Admin Page
- **Features:** Backup, export, import, storage info

### 🔟 Audit Logs Screen
- **File:** `lib/screens/audit_logs_screen.dart`
- **Route:** From Admin Dashboard
- **Access:** `Navigator.push(context, MaterialPageRoute(builder: (c) => AuditLogsScreen()))`
- **Type:** Admin Page
- **Features:** Activity logs, filters, export

---

## 📂 Complete Directory Structure

```
lib/
├── screens/                          (Total: 54 screens)
│   │
│   ├── ✅ NEW SCREENS (10 files)
│   ├── blog_screen.dart
│   ├── blog_article_screen.dart
│   ├── services_screen.dart
│   ├── challenges_screen.dart
│   ├── leaderboard_screen.dart
│   ├── change_password_screen.dart
│   ├── admin_dashboard_screen.dart
│   ├── user_management_screen.dart
│   ├── data_management_screen.dart
│   └── audit_logs_screen.dart
│   │
│   ├── 🔵 EXISTING SCREENS (44 files)
│   ├── splash_screen.dart
│   ├── welcome_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── dashboard_screen.dart
│   ├── home_screen.dart
│   ├── profile_screen.dart
│   ├── workout_tracker_screen.dart
│   ├── meal_tracker_screen.dart
│   ├── sleep_tracker_screen.dart
│   └── ... (34 more existing screens)
│
├── services/                         (Total: 4 services)
│   ├── ✅ auth_service.dart         (NEW - Auto-login)
│   ├── ✅ permission_service.dart   (NEW - Permissions)
│   ├── ✅ localization_service.dart (NEW - Languages)
│   └── ✅ user_service.dart         (NEW - User CRUD)
│
├── models/                           (Total: 1 model)
│   └── ✅ user_model.dart           (NEW - User data)
│
├── l10n/                             (Total: 2 files)
│   ├── ✅ app_en.dart               (NEW - English)
│   └── ✅ app_hi.dart               (NEW - Hindi)
│
├── theme/
│   └── theme.dart
│
├── widgets/
│   ├── custom_button.dart
│   ├── custom_textfield.dart
│   └── app_logo.dart
│
├── globals.dart
└── main.dart                         (UPDATED)
```

---

## 🎯 How to Access Each Screen

### From Code (Any Screen):

```dart
// Blog
Navigator.pushNamed(context, '/blog');

// Services
Navigator.pushNamed(context, '/services');

// Challenges
Navigator.pushNamed(context, '/challenges');

// Leaderboard
Navigator.pushNamed(context, '/leaderboard');

// Change Password
Navigator.pushNamed(context, '/change_password');

// Admin Dashboard
Navigator.pushNamed(context, '/admin_dashboard');
```

### From UI (User Flow):

#### Guest Pages:
```
Welcome Screen
    ↓
[Blog Button] → Blog Screen → Article
[Services Button] → Services Screen
[Contact Button] → Contact Screen
```

#### User Pages:
```
Dashboard (After Login)
    ↓
Home Tab
    ↓
[Challenges Card] → Challenges Screen
[Leaderboard Card] → Leaderboard Screen
    
Profile Tab
    ↓
[Settings] → Change Password
[Language] → Language Selector
```

#### Admin Pages:
```
Dashboard (After Login)
    ↓
Profile → Settings → Admin Panel
    ↓
Admin Dashboard
    ↓
[User Management] → User CRUD
[Data Management] → Database Operations
[Audit Logs] → Activity Logs
```

---

## 🔍 Quick Search Commands

### In VS Code / Android Studio:

1. **Find Blog Screen:**
   - Press `Ctrl+P` (Windows) or `Cmd+P` (Mac)
   - Type: `blog_screen.dart`

2. **Find Services Screen:**
   - Press `Ctrl+P` or `Cmd+P`
   - Type: `services_screen.dart`

3. **Find Admin Dashboard:**
   - Press `Ctrl+P` or `Cmd+P`
   - Type: `admin_dashboard_screen.dart`

4. **Find User Management:**
   - Press `Ctrl+P` or `Cmd+P`
   - Type: `user_management_screen.dart`

5. **Search All New Screens:**
   - Press `Ctrl+Shift+F` (Windows) or `Cmd+Shift+F` (Mac)
   - Search: `class.*Screen extends`
   - Filter by: `lib/screens/`

---

## 📊 Screen Count Summary

| Category | Count | Status |
|----------|-------|--------|
| Guest Pages | 3 | ✅ Added (Blog, Blog Article, Services) |
| User Pages | 3 | ✅ Added (Challenges, Leaderboard, Change Password) |
| Admin Pages | 4 | ✅ Added (Dashboard, User Mgmt, Data Mgmt, Audit Logs) |
| **Total New** | **10** | **✅ Complete** |
| Existing Screens | 44 | ✅ Already Present |
| **Grand Total** | **54** | **✅ All Working** |

---

## 🚀 Testing Checklist

### ✅ Test New Screens:

```bash
# 1. Run the app
flutter run

# 2. Test Guest Pages (Before Login)
- Open app → Welcome → Click "Blog" → Should open Blog Screen
- Click any article → Should open Blog Article Screen
- Go back → Click "Services" → Should open Services Screen

# 3. Test User Pages (After Login)
- Login with any credentials
- Dashboard → Home → Find "Challenges" card → Click
- Dashboard → Home → Find "Leaderboard" card → Click
- Dashboard → Profile → Settings → Change Password

# 4. Test Admin Pages (After Login)
- Dashboard → Profile → Settings → Admin Panel
- Admin Dashboard → User Management → Add/Edit/Delete users
- Admin Dashboard → Data Management → View operations
- Admin Dashboard → Audit Logs → View logs

# 5. Test Language Change
- Dashboard → Profile → Language → Select Hindi
- App should change to Hindi instantly
- Change back to English

# 6. Test Auto-Login
- Login once
- Close app completely
- Reopen app
- Should go directly to Dashboard (no login screen)
```

---

## 💡 Pro Tips

1. **All new screens are in:** `lib/screens/` folder
2. **All routes are in:** `lib/main.dart` file
3. **Search in VS Code:** `Ctrl+P` then type screen name
4. **View all screens:** Open `lib/screens/` folder in file explorer
5. **Test routes:** Use `Navigator.pushNamed(context, '/route_name')`

---

## 📱 Screen Preview

### Blog Screen
- Article cards with images
- Search bar
- Category filters
- Featured article section

### Challenges Screen
- Active challenges tab
- Completed challenges tab
- Progress bars
- Join challenge buttons

### Leaderboard Screen
- Top 3 podium display
- User rankings list
- Weekly/Monthly/All-time tabs
- Points display

### Admin Dashboard
- User statistics cards
- Activity graph
- Quick action buttons
- Recent activity feed

### User Management
- User list with search
- Add user dialog
- Edit user dialog
- Delete confirmation
- Stats (Total/Active/Inactive)

---

## 🎨 UI Components Used

All new screens use:
- ✅ Responsive design (flutter_screenutil)
- ✅ Custom colors (AppColors)
- ✅ Material Design
- ✅ Smooth animations
- ✅ Loading states
- ✅ Error handling
- ✅ Success messages

---

## 📞 Need Help?

If you can't find a screen:
1. Check `lib/screens/` folder
2. Search in VS Code: `Ctrl+P` → type screen name
3. Check `main.dart` for route names
4. Refer to this document for file locations
