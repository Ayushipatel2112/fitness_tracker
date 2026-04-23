import 'package:flutter/material.dart';
import '../services/permission_service.dart';

class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({super.key});

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  bool _vibrate = true;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  Future<void> _checkAndRequestPermission() async {
    final hasPermission = await PermissionService.hasAlarmPermission();
    
    if (!hasPermission) {
      final wasAsked = await PermissionService.wasAlarmPermissionAsked();
      
      if (!wasAsked) {
        // First time, show dialog explaining why we need permission
        if (mounted) {
          final shouldAsk = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Enable Alarms'),
              content: const Text(
                'Allow the app to set alarms for your sleep schedule and workout reminders. Never miss your fitness goals!',
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
            await PermissionService.requestAlarmPermission();
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
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            icon: const Icon(Icons.close, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Add Alarm', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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
            _listItem('Bedtime', '09:00 PM', Icons.bed, true),
            _listItem('Hours of sleep', '8hours 30minutes', Icons.access_time, true),
            _listItem('Repeat', 'Mon to Fri', Icons.repeat, true),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.vibration, color: Colors.grey.shade600, size: 20),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text('Vibrate When Alarm Sound', style: TextStyle(color: Colors.black87, fontSize: 14)),
                  ),
                  Switch(
                    value: _vibrate,
                    onChanged: (val) {
                      setState(() {
                        _vibrate = val;
                      });
                    },
                    activeColor: Colors.purple.shade300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              // Check permission before adding alarm
              final hasPermission = await PermissionService.hasAlarmPermission();
              
              if (!hasPermission) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Alarm permission is required to set alarms'),
                    ),
                  );
                }
                return;
              }
              
              // Add alarm logic here
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Alarm added successfully!')),
                );
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF92A3FD),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              elevation: 0,
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _listItem(String title, String value, IconData icon, bool hasArrow) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.black87, fontSize: 14)),
          ),
          Text(value, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          if (hasArrow) ...[
            const SizedBox(width: 10),
            Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 14),
          ]
        ],
      ),
    );
  }
}
