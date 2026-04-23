import 'package:flutter/material.dart';
import 'reset_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsOn = true;
  bool _darkModeOn = false;
  bool _soundOn = true;
  String _selectedLanguage = 'English';

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['English', 'Hindi', 'Spanish', 'French'].map((lang) {
              return ListTile(
                title: Text(lang),
                trailing: _selectedLanguage == lang ? const Icon(Icons.check, color: Colors.purple) : null,
                onTap: () {
                  setState(() => _selectedLanguage = lang);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account Deleted!')));
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

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
        title: const Text('Settings', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('General', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildSettingToggle('App Notifications', _notificationsOn, (val) => setState(() => _notificationsOn = val)),
            _buildSettingToggle('Dark Mode', _darkModeOn, (val) {
              setState(() => _darkModeOn = val);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Theme changed!')));
            }),
            _buildSettingToggle('Sound', _soundOn, (val) => setState(() => _soundOn = val)),
            const SizedBox(height: 30),
            const Text('Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildSettingItem('Language', _selectedLanguage, onTap: _showLanguageDialog),
            _buildSettingItem(
              'Change Password', 
              '', 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordScreen()));
              }
            ),
            _buildSettingItem('Delete Account', '', isDestructive: true, onTap: _confirmDeleteAccount),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingToggle(String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.purple.shade300,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      ),
    );
  }

  Widget _buildSettingItem(String title, String trailingText, {bool isDestructive = false, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        title: Text(
          title, 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red : Colors.black,
          )
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText.isNotEmpty)
              Text(trailingText, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(width: 5),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      ),
    );
  }
}
