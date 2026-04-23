import 'package:flutter/material.dart';
import '../services/permission_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  Future<void> _checkAndRequestPermission() async {
    final hasPermission = await PermissionService.hasNotificationPermission();
    
    if (!hasPermission) {
      final wasAsked = await PermissionService.wasNotificationPermissionAsked();
      
      if (!wasAsked) {
        // First time, show dialog explaining why we need permission
        if (mounted) {
          final shouldAsk = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Enable Notifications'),
              content: const Text(
                'Get notified about your workouts, meals, and fitness goals. Stay on track with timely reminders!',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Not Now'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF92A3FD),
                  ),
                  child: const Text('Enable', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );

          if (shouldAsk == true) {
            await PermissionService.requestNotificationPermission();
          }
        }
      }
    }
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
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Notification', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          _notificationItem('Hey, it\'s time for lunch', 'About 1 minutes ago', Icons.fastfood, Colors.orange),
          const Divider(),
          _notificationItem('Don\'t miss your lowerbody workout', 'About 3 hours ago', Icons.directions_run, Colors.purple),
          const Divider(),
          _notificationItem('Hey, let\'s add some meals for your b...', 'About 3 hours ago', Icons.restaurant_menu, Colors.orange),
          const Divider(),
          _notificationItem('Congratulations, You have finished A...', '29 May', Icons.celebration, Colors.blue),
          const Divider(),
          _notificationItem('Hey, it\'s time for lunch', '8 April', Icons.fastfood, Colors.grey),
          const Divider(),
          _notificationItem('Ups, You have missed your Lowerbo...', '3 April', Icons.warning, Colors.purple),
        ],
      ),
    );
  }

  Widget _notificationItem(String title, String time, IconData iconData, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            radius: 25,
            child: Icon(iconData, color: iconColor, size: 25),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black)),
                const SizedBox(height: 5),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.more_vert, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}
