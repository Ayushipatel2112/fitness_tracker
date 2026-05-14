import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login_screen.dart';
import '../workouts_screen.dart';
import '../meals_screen.dart';
import '../sleep_screen.dart';

import 'admin_manage_users.dart';
import 'admin_manage_contacts.dart';
import 'admin_analytics_screen.dart';
import 'admin_settings_screen.dart';
import 'admin_security_screen.dart';
import 'admin_help_screen.dart';
import '../../services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                onChanged: (value) {
                  // Implement search logic here if needed
                },
              )
            : const Text('Admin Dashboard',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF92A3FD), // Consistent Light Blue
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search,
                color: Colors.white),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchController.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseService.systemSettingsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.exists) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                if (data['maintenance_mode'] ?? false) {
                  return Container(
                    width: double.infinity,
                    color: Colors.orange.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.engineering, color: Colors.white, size: 16),
                        SizedBox(width: 10),
                        Text(
                          'System is in Maintenance Mode',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(child: _buildBody()),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF92A3FD),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).cardColor,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded), label: 'Stats'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_rounded), label: 'Alerts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return _buildStatsContent();
      case 2:
        return _buildAlertsContent();
      case 3:
        return _buildProfileContent();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeHeader(),
          const SizedBox(height: 30),
          Text(
            'Management Tools',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1D1617)),
          ),
          const SizedBox(height: 15),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.1,
            children: [
              _buildAdminCard(
                context,
                title: 'Workouts',
                icon: Icons.fitness_center,
                color1: const Color(0xFF9DCEFF),
                color2: const Color(0xFF92A3FD),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkoutsScreen(isAdminView: true))),
              ),
              _buildAdminCard(
                context,
                title: 'Meals',
                icon: Icons.restaurant,
                color1: const Color(0xFFEEA4CE),
                color2: const Color(0xFFC58BF2),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MealsScreen(isAdminView: true))),
              ),
              _buildAdminCard(
                context,
                title: 'Sleep Data',
                icon: Icons.bedtime,
                color1: const Color(0xFF9DCEFF),
                color2: const Color(0xFFC58BF2),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SleepScreen(isAdminView: true))),
              ),
              _buildAdminCard(
                context,
                title: 'Users',
                icon: Icons.people,
                color1: Colors.orange.shade300,
                color2: Colors.red.shade400,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminManageUsersScreen())),
              ),
              _buildAdminCard(
                context,
                title: 'Messages',
                icon: Icons.message,
                color1: const Color(0xFF92A3FD),
                color2: const Color(0xFFC58BF2),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AdminManageContactsScreen())),
              ),
              _buildAdminCard(
                context,
                title: 'Analytics',
                icon: Icons.analytics,
                color1: const Color(0xFFC58BF2),
                color2: const Color(0xFFEEA4CE),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminAnalyticsScreen())),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF92A3FD).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome, Admin!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                'Manage your platform data\ndynamically from here.',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 13),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.admin_panel_settings,
                color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsContent() {
    return const AdminAnalyticsScreen();
  }

  Widget _buildAlertsContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        // Refined Background Shapes (Dashboard Optimized)
        Positioned(
          top: -40,
          left: -30,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
                color:
                    const Color(0xFF1D2671).withOpacity(isDark ? 0.15 : 0.06),
                shape: BoxShape.circle),
          ),
        ),
        Positioned(
          bottom: 100,
          right: -50,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
                color:
                    const Color(0xFFC33764).withOpacity(isDark ? 0.12 : 0.04),
                borderRadius: BorderRadius.circular(60)),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('System Alerts',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF1D1617))),
              const SizedBox(height: 5),
              Text('Real-time notifications about platform health.',
                  style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.grey,
                      fontSize: 14)),
              const SizedBox(height: 30),
              _buildAlertTile(
                  'Database Load High',
                  'System detected 85% CPU usage on database node.',
                  '2 mins ago',
                  Colors.redAccent,
                  Icons.warning_rounded),
              _buildAlertTile(
                  'New Support Message',
                  'User "Ayushi" sent a new query regarding meal plans.',
                  '15 mins ago',
                  const Color(0xFF92A3FD),
                  Icons.mail_rounded),
              _buildAlertTile(
                  'Backup Successful',
                  'Daily system backup completed successfully.',
                  '1 hour ago',
                  Colors.green,
                  Icons.cloud_done_rounded),
              _buildAlertTile(
                  'User Report',
                  'A user profile has been reported for suspicious activity.',
                  '3 hours ago',
                  Colors.orange,
                  Icons.report_problem_rounded),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAlertTile(
      String title, String desc, String time, Color color, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
              blurRadius: 15,
              offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1D1617))),
                    Text(time,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(desc,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        // Abstract Background Shapes (Refined Size)
        Positioned(
          top: -80,
          left: -40,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
                color:
                    const Color(0xFF1D2671).withOpacity(isDark ? 0.15 : 0.06),
                shape: BoxShape.circle),
          ),
        ),
        Positioned(
          bottom: 20,
          right: -60,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
                color:
                    const Color(0xFFC33764).withOpacity(isDark ? 0.12 : 0.04),
                borderRadius: BorderRadius.circular(80)),
          ),
        ),

        // Content
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.all(35),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1D2671),
                      Color(0xFF334366)
                    ], // Dark Slate Gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFF1D2671).withOpacity(0.4),
                        blurRadius: 25,
                        offset: const Offset(0, 12))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFFC33764), Color(0xFF1D2671)]),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFF1D2671),
                        child: Icon(Icons.admin_panel_settings_rounded,
                            color: Colors.white, size: 55),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text('Admin User',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const Text('platform_admin@fitness.com',
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text('SUPER ADMIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              _buildProfileOption(Icons.settings_outlined, 'System Settings',
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminSettingsScreen()))),
              _buildProfileOption(Icons.security_outlined, 'Security & Roles',
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminSecurityScreen()))),
              _buildProfileOption(Icons.help_outline_rounded, 'Help Center',
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminHelpScreen()))),
              const SizedBox(height: 30),
              TextButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  }
                },
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.redAccent.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                icon: const Icon(Icons.logout_rounded,
                    color: Colors.redAccent, size: 20),
                label: const Text('Log out of Account',
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(IconData icon, String label, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.15 : 0.03),
                  blurRadius: 10)
            ]),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF92A3FD), size: 22),
            const SizedBox(width: 18),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isDark ? Colors.white : const Color(0xFF1D1617))),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,
                size: 14, color: isDark ? Colors.white54 : Colors.grey),
          ],
        ),
      ),
    );
  }


  Widget _buildAdminCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color1,
      required Color color2,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
                color: color2.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

}
