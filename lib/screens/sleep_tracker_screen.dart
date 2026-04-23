import 'package:flutter/material.dart';
import 'sleep_schedule_screen.dart';

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({super.key});

  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  bool _bedtimeAlarm = true;
  bool _wakeupAlarm = false;

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
        title: const Text('Sleep Tracker', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart Area Placeholder
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: const Center(child: Text('Graph Component\n(Sleep duration over days)', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey))),
            ),
            const SizedBox(height: 30),
            
            // Last Night Sleep Banner
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Last Night Sleep', style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(height: 5),
                  Text('8h 20m', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            
            // Daily Sleep Schedule
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF92A3FD).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Daily Sleep Schedule', style: TextStyle(fontWeight: FontWeight.w600)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => const SleepScheduleScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF92A3FD),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    ),
                    child: const Text('Check', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            
            // Today Schedule
            const Text('Today Schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _alarmItem('Bedtime', '09:00pm', 'in 6hours 22minutes', Icons.bed, _bedtimeAlarm, (v) {
              setState(() { _bedtimeAlarm = v; });
            }),
            _alarmItem('Wake up', '05:10am', 'in 14hours 30minutes', Icons.access_alarms, _wakeupAlarm, (v) {
              setState(() { _wakeupAlarm = v; });
            }),
          ],
        ),
      ),
    );
  }

  Widget _alarmItem(String title, String time, String timeLeft, IconData iconData, bool isActive, Function(bool) onToggle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          Icon(iconData, color: isActive ? Colors.purple.shade300 : Colors.red.shade300),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(width: 5),
                    Text(', $time', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(timeLeft, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.more_vert, color: Colors.grey, size: 18),
              Switch(value: isActive, onChanged: onToggle, activeColor: Colors.purple.shade300),
            ],
          ),
        ],
      ),
    );
  }
}
