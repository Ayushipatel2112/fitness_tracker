import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firebase_service.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  // Local state to keep track of toggling to make it feel responsive
  final Map<String, bool> _localToggles = {};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1D1617);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('System Settings', 
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseService.systemSettingsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          }

          if (snapshot.connectionState == ConnectionState.waiting && _localToggles.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF92A3FD)));
          }

          bool maintenanceMode = false;
          bool emailNotifications = true;
          bool autoBackups = true;
          bool pushNotifications = true;

          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            maintenanceMode = _localToggles['maintenance_mode'] ?? (data['maintenance_mode'] ?? false);
            emailNotifications = _localToggles['email_notifications'] ?? (data['email_notifications'] ?? true);
            autoBackups = _localToggles['auto_backups'] ?? (data['auto_backups'] ?? true);
            pushNotifications = _localToggles['push_notifications'] ?? (data['push_notifications'] ?? true);
          } else {
            // Document doesn't exist, use default values or local toggles
            maintenanceMode = _localToggles['maintenance_mode'] ?? false;
            emailNotifications = _localToggles['email_notifications'] ?? true;
            autoBackups = _localToggles['auto_backups'] ?? true;
            pushNotifications = _localToggles['push_notifications'] ?? true;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('General Settings'),
                _buildSettingsSwitch(
                  'Maintenance Mode', 
                  'Disable user access for maintenance', 
                  maintenanceMode,
                  (val) => _handleToggle('maintenance_mode', val),
                  Icons.engineering_outlined,
                ),
                _buildSettingsSwitch(
                  'Email Notifications', 
                  'Send system alerts via email', 
                  emailNotifications,
                  (val) => _handleToggle('email_notifications', val),
                  Icons.email_outlined,
                ),
                _buildSettingsSwitch(
                  'Auto-Backups', 
                  'Perform daily database backups', 
                  autoBackups,
                  (val) => _handleToggle('auto_backups', val),
                  Icons.backup_outlined,
                ),
                _buildSettingsSwitch(
                  'Push Notifications', 
                  'Send notifications to admin devices', 
                  pushNotifications,
                  (val) => _handleToggle('push_notifications', val),
                  Icons.notifications_active_outlined,
                ),
                
                const SizedBox(height: 30),
                _buildSectionHeader('System Info'),
                _buildActionItem('App Version', 'v1.0.4 (Stable)', Icons.info_outline),
                _buildActionItem('Server Status', maintenanceMode ? 'Maintenance' : 'Operational', Icons.dns_outlined),
                _buildActionItem('Last Backup', 'Today, 04:00 AM', Icons.history),
                
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'Fitness Tracker Admin Panel\n© 2024 All Rights Reserved',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Future<void> _handleToggle(String key, bool val) async {
    setState(() {
      _localToggles[key] = val;
    });

    try {
      await FirebaseService.updateSystemSetting(key, val);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${key.replaceAll('_', ' ').toUpperCase()} updated successfully'),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.green,
          )
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _localToggles.remove(key); // Revert local state on error
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update setting: $e'), backgroundColor: Colors.red)
        );
      }
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 15),
      child: Text(title, 
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF92A3FD))),
    );
  }

  Widget _buildSettingsSwitch(String title, String sub, bool value, Function(bool) onChanged, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1D1617) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.02),
                blurRadius: 10)
          ]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF92A3FD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF92A3FD), size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black)),
                Text(sub,
                    style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey,
                        fontSize: 11)),
              ],
            ),
          ),
          Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF92A3FD)),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title, String val, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1D1617) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.02),
                blurRadius: 10)
          ]),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF92A3FD), size: 20),
          const SizedBox(width: 15),
          Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black))),
          Text(val,
              style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.grey, fontSize: 12)),
          const SizedBox(width: 10),
          Icon(Icons.arrow_forward_ios,
              size: 12, color: isDark ? Colors.white54 : Colors.grey),
        ],
      ),
    );
  }
}
