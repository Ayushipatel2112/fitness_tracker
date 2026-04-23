import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../theme/theme.dart';
import '../services/auth_service.dart';
import '../globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    // Check if user is already logged in
    final isLoggedIn = await AuthService.isLoggedIn();
    if (!mounted) return; // check again after await

    if (isLoggedIn) {
      // Load saved user data into global variables
      globals.currentUserName  = await AuthService.getUserName();
      globals.currentUserEmail = await AuthService.getUserEmail();
      globals.currentUserRole  = await AuthService.getUserRole();

      if (!mounted) return; // check again after multiple awaits

      // Role-based redirect
      if (globals.isAdmin) {
        Navigator.pushReplacementNamed(context, '/admin_dashboard');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      // Not logged in → show welcome screen (guest access)
      globals.currentUserRole = 'guest';
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.primaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(size: 100),
            const SizedBox(height: 20),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Fit',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'ness',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Everybody Can Train',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
