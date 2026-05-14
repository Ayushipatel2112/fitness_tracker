import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'dashboard_screen.dart';
import 'welcome_screen.dart';
import 'maintenance_screen.dart';
import 'admin/admin_dashboard_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseService.systemSettingsStream(),
      builder: (context, settingsSnapshot) {
        if (settingsSnapshot.hasError) {
          return Scaffold(body: Center(child: Text('Settings Error: ${settingsSnapshot.error}')));
        }

        bool isMaintenance = false;
        if (settingsSnapshot.hasData && settingsSnapshot.data != null && settingsSnapshot.data!.exists) {
          try {
            final data = settingsSnapshot.data!.data() as Map<String, dynamic>?;
            isMaintenance = data?['maintenance_mode'] ?? false;
          } catch (e) {
            isMaintenance = false;
          }
        }

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.waiting || 
                (settingsSnapshot.connectionState == ConnectionState.waiting && !settingsSnapshot.hasData)) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (authSnapshot.hasError) {
              return Scaffold(body: Center(child: Text('Auth Error: ${authSnapshot.error}')));
            }

            final user = authSnapshot.data;

            if (user != null) {
              return FutureBuilder<bool>(
                future: FirebaseService.isAdmin(),
                builder: (context, adminSnapshot) {
                  if (adminSnapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(body: Center(child: CircularProgressIndicator()));
                  }

                  bool isAdmin = adminSnapshot.data ?? false;

                  if (isAdmin) {
                    return const AdminDashboardScreen();
                  } else {
                    if (isMaintenance) {
                      return const MaintenanceScreen();
                    }
                    return const DashboardScreen();
                  }
                },
              );
            }

            // Not logged in
            if (isMaintenance) {
              return const MaintenanceScreen();
            }
            return const WelcomeScreen();
          },
        );
      },
    );
  }
}
