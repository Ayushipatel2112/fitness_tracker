import 'package:flutter/material.dart';

class AdminSecurityScreen extends StatefulWidget {
  const AdminSecurityScreen({super.key});

  @override
  State<AdminSecurityScreen> createState() => _AdminSecurityScreenState();
}

class _AdminSecurityScreenState extends State<AdminSecurityScreen> {
  bool _twoFactorAuth = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1D1617);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF7F8F8),
      appBar: AppBar(
        title: Text('Security & Roles', 
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Account Security'),
            _buildSecurityItem(
              'Admin Credentials', 
              'Update your email and password', 
              Icons.lock_outline,
              () => _showUpdateDialog('Credentials'),
            ),
            _buildSecuritySwitch(
              'Two-Factor Auth', 
              'Currently Enabled', 
              _twoFactorAuth,
              (val) => setState(() => _twoFactorAuth = val),
              Icons.verified_user_outlined,
            ),
            
            const SizedBox(height: 30),
            _buildSectionHeader('Access Control'),
            _buildSecurityItem(
              'Active Sessions', 
              '3 devices currently connected', 
              Icons.devices_outlined,
              () => _showUpdateDialog('Sessions'),
            ),
            _buildSecurityItem(
              'Role Management', 
              'Assign and modify permissions', 
              Icons.admin_panel_settings_outlined,
              () => _showUpdateDialog('Roles'),
            ),
            _buildSecurityItem(
              'Audit Logs', 
              'View recent admin actions', 
              Icons.list_alt_outlined,
              () => _showUpdateDialog('Logs'),
            ),

            const SizedBox(height: 30),
            _buildSectionHeader('Data Protection'),
            _buildSecurityItem(
              'Privacy Policy', 
              'Update platform privacy rules', 
              Icons.privacy_tip_outlined,
              () => {},
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateDialog(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Update $type'),
        content: Text('This feature will allow you to manage $type in the final version.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 15),
      child: Text(title, 
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC58BF2))),
    );
  }

  Widget _buildSecurityItem(String title, String sub, IconData icon, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.15 : 0.02),
                  blurRadius: 10)
            ]),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFC58BF2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFC58BF2), size: 22),
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
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySwitch(String title, String sub, bool value, Function(bool) onChanged, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.15 : 0.02),
                blurRadius: 10)
          ]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFC58BF2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFC58BF2), size: 22),
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
              activeColor: const Color(0xFFC58BF2)),
        ],
      ),
    );
  }
}
