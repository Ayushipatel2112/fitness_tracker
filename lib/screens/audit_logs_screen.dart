import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuditLogsScreen extends StatefulWidget {
  const AuditLogsScreen({super.key});

  @override
  State<AuditLogsScreen> createState() => _AuditLogsScreenState();
}

class _AuditLogsScreenState extends State<AuditLogsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Audit Logs',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting logs...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _filterChip('All'),
                _filterChip('User'),
                _filterChip('Admin'),
                _filterChip('System'),
                _filterChip('Error'),
              ],
            ),
          ),

          // Logs List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _logItem(
                  'User Login',
                  'john.doe@email.com logged in',
                  DateTime.now().subtract(const Duration(minutes: 5)),
                  'User',
                  Icons.login,
                  const Color(0xFF92A3FD),
                ),
                _logItem(
                  'Profile Updated',
                  'sarah.smith@email.com updated profile',
                  DateTime.now().subtract(const Duration(minutes: 15)),
                  'User',
                  Icons.edit,
                  const Color(0xFFC58BF2),
                ),
                _logItem(
                  'Admin Action',
                  'Admin deleted user account',
                  DateTime.now().subtract(const Duration(hours: 1)),
                  'Admin',
                  Icons.admin_panel_settings,
                  Colors.orange,
                ),
                _logItem(
                  'Database Backup',
                  'Automated backup completed',
                  DateTime.now().subtract(const Duration(hours: 2)),
                  'System',
                  Icons.backup,
                  Colors.green,
                ),
                _logItem(
                  'Failed Login',
                  'Failed login attempt from unknown IP',
                  DateTime.now().subtract(const Duration(hours: 3)),
                  'Error',
                  Icons.error,
                  Colors.red,
                ),
                _logItem(
                  'User Registration',
                  'New user registered: emma.w@email.com',
                  DateTime.now().subtract(const Duration(hours: 4)),
                  'User',
                  Icons.person_add,
                  const Color(0xFF92A3FD),
                ),
                _logItem(
                  'Data Export',
                  'Admin exported user data',
                  DateTime.now().subtract(const Duration(hours: 5)),
                  'Admin',
                  Icons.download,
                  Colors.orange,
                ),
                _logItem(
                  'Password Reset',
                  'mike.j@email.com reset password',
                  DateTime.now().subtract(const Duration(hours: 6)),
                  'User',
                  Icons.lock_reset,
                  const Color(0xFFC58BF2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _selectedFilter = label);
        },
        backgroundColor: Colors.grey.shade100,
        selectedColor: const Color(0xFF92A3FD),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _logItem(
    String title,
    String description,
    DateTime timestamp,
    String type,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 11,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat('MMM dd, yyyy - HH:mm').format(timestamp),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
