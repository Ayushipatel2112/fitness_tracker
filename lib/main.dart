import 'package:flutter/material.dart';

// Importing all screens
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/intro1_screen.dart';
import 'screens/intro2_screen.dart';
import 'screens/intro3_screen.dart';
import 'screens/intro4_screen.dart';
import 'screens/gender_selection_screen.dart';
import 'screens/profile_info_screen.dart';
import 'screens/goal_selection_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/success_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/blog_screen.dart';
import 'screens/services_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/admin_dashboard_screen.dart';

// Entry point of the app
void main() {
  runApp(const MyApp());
}

// MyApp is a StatelessWidget - it never changes, so no State needed
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',

      // ── Theme ─────────────────────────────────────────────────────
      theme: ThemeData(
        primarySwatch: Colors.pink,

        // Background color of the app
        scaffoldBackgroundColor: Colors.grey[200],

        // AppBar background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 167, 3, 85),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),

        // ElevatedButton style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 158, 9, 91),
            foregroundColor: Colors.white,
            shadowColor: Color.fromARGB(255, 218, 7, 123),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        // TextField style
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 167, 3, 85),
            ),
          ),
        ),
      ),

      // ── Routes ────────────────────────────────────────────────────
      initialRoute: '/',
      routes: {
        '/'                : (context) => const SplashScreen(),
        '/welcome'         : (context) => const WelcomeScreen(),
        '/intro1'          : (context) => const Intro1Screen(),
        '/intro2'          : (context) => const Intro2Screen(),
        '/intro3'          : (context) => const Intro3Screen(),
        '/intro4'          : (context) => const Intro4Screen(),
        '/register'        : (context) => const RegisterScreen(),
        '/gender_selection': (context) => const GenderSelectionScreen(),
        '/profile_info'    : (context) => const ProfileInfoScreen(),
        '/goal_selection'  : (context) => const GoalSelectionScreen(),
        '/login'           : (context) => const LoginScreen(),
        '/success'         : (context) => const SuccessScreen(),
        '/home'            : (context) => const DashboardScreen(),
        '/blog'            : (context) => const BlogScreen(),
        '/services'        : (context) => const ServicesScreen(),
        '/change_password' : (context) => const ChangePasswordScreen(),
        '/challenges'      : (context) => const ChallengesScreen(),
        '/leaderboard'     : (context) => const LeaderboardScreen(),
        '/admin_dashboard' : (context) => const AdminDashboardScreen(),
      },
    );
  }
}
