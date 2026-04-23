import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../services/auth_service.dart';
import 'profile_sub_screens.dart';
import 'edit_profile_screen.dart';
import 'contact_screen.dart';
import 'personal_data_screen.dart';
import 'achievement_screen.dart';
import 'workout_progress_screen.dart';
import 'settings_screen.dart';
import 'privacy_screen.dart';


// ProfileScreen shows the user's profile details and settings
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
            child: IconButton(icon: const Icon(Icons.more_horiz, color: Colors.black), onPressed: () {}),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // User Header
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.purple.shade100, radius: 25, child: const Icon(Icons.person, color: Colors.purple)),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(globals.currentUserName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 5),
                      Text('Lose a Fat Program', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => const EditProfileScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF92A3FD),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  ),
                  child: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Stats Row
            Row(
              children: [
                Expanded(child: _statCard('180cm', 'Height')),
                const SizedBox(width: 15),
                Expanded(child: _statCard('65kg', 'Weight')),
                const SizedBox(width: 15),
                Expanded(child: _statCard('22yo', 'Age')),
              ],
            ),
            const SizedBox(height: 30),
            
            // Account Details
            _sectionContainer(
              title: 'Account',
              children: [
                _menuItem(Icons.person_outline, 'Personal Data', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PersonalDataScreen()))),
                _menuItem(Icons.star_outline, 'Achievement', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const AchievementScreen()))),
                _menuItem(Icons.history, 'Activity History', onTap: () => _navTo(context, 'Activity History')),
                _menuItem(Icons.insert_chart_outlined, 'Workout Progress', isLast: true, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const WorkoutProgressScreen()))),
              ],
            ),
            const SizedBox(height: 20),
            
            // Notification
            _sectionContainer(
              title: 'Notification',
              children: [
                _toggleItem(Icons.notifications_none, 'Pop-up Notification', _notificationsOn, (val) {
                  setState(() { _notificationsOn = val; });
                }, isLast: true),
              ],
            ),
            const SizedBox(height: 20),
            
            // Other
            _sectionContainer(
              title: 'Other',
              children: [
                _menuItem(Icons.mail_outline, 'Contact Us', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const ContactScreen()))),
                _menuItem(Icons.privacy_tip_outlined, 'Privacy Policy', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PrivacyScreen()))),
                _menuItem(Icons.language, 'Language', onTap: () {
                  // Show a simple message for now
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Language settings coming soon!')),
                  );
                }),
                _menuItem(Icons.settings_outlined, 'Settings', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const SettingsScreen()))),
                _menuItem(
                  Icons.logout, 
                  'Logout', 
                  isLast: true, 
                  onTap: () async {
                    // Show confirmation dialog
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF92A3FD),
                            ),
                            child: const Text('Logout', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );

                    if (shouldLogout == true && mounted) {
                      // Clear login state
                      await AuthService.logout();
                      
                      // Reset global name
                      globals.currentUserName = 'Stefani Wong';
                      
                      // Navigate to login
                      if (mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navTo(BuildContext context, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => GenericProfileSubScreen(title: title)));
  }

  // Language dialog removed - no longer needed

  Widget _statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Color(0xFF92A3FD), fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _sectionContainer({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, {bool isLast = false, VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: const Color(0xFF92A3FD)),
          title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
        if (!isLast) Divider(color: Colors.grey.shade200),
      ],
    );
  }

  Widget _toggleItem(IconData icon, String title, bool value, Function(bool) onChanged, {bool isLast = false}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: const Color(0xFF92A3FD)),
          title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          trailing: Switch(value: value, onChanged: onChanged, activeColor: Colors.purple.shade300),
        ),
        if (!isLast) Divider(color: Colors.grey.shade200),
      ],
    );
  }
}
