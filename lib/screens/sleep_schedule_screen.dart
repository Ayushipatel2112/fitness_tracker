import 'package:flutter/material.dart';

import 'add_alarm_screen.dart';

class SleepScheduleScreen extends StatefulWidget {
  const SleepScheduleScreen({super.key});

  @override
  State<SleepScheduleScreen> createState() => _SleepScheduleScreenState();
}

class _SleepScheduleScreenState extends State<SleepScheduleScreen> {
  bool _bedtimeActive = true;
  bool _alarmActive = true;

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
        title: const Text('Sleep Schedule', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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
            // Ideal Hours Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF92A3FD).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Ideal Hours for Sleep', style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 5),
                        const Text('8hours 30minutes', style: TextStyle(color: Color(0xFF92A3FD), fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF92A3FD),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          ),
                          child: const Text('Learn More', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.bedtime, size: 60, color: Colors.amber),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Your Schedule
            const Text('Your Schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            
            // Calendar Strip
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _dateView('Tue', '11', false),
                  _dateView('Wed', '12', false),
                  _dateView('Thu', '13', false),
                  _dateView('Fri', '14', true), // Selected Date
                  _dateView('Sat', '15', false),
                  _dateView('Sun', '16', false),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Alarms
            _alarmItem('Bedtime, 09:00pm', 'in 6hours 22minutes', Icons.bed, _bedtimeActive, (v) {
              setState(() { _bedtimeActive = v; });
            }),
            _alarmItem('Alarm, 05:10am', 'in 14hours 30minutes', Icons.access_alarms, _alarmActive, (v) {
              setState(() { _alarmActive = v; });
            }),
            
            const SizedBox(height: 20),
            
            // Today info card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                       Text('You will get 8hours 10minutes', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    ],
                  ),
                  const Text('for tonight', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Container(height: 10, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5))),
                      Container(height: 10, width: 250, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple.shade200, Colors.purple.shade400]), borderRadius: BorderRadius.circular(5))),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Center(child: Text('96%', style: TextStyle(color: Colors.purple, fontSize: 12))),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => const AddAlarmScreen()));
        },
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  
  Widget _dateView(String day, String date, bool isSelected) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: isSelected ? const LinearGradient(colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)]) : null,
        color: !isSelected ? Colors.grey.shade100 : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(day, style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontSize: 12)),
          const SizedBox(height: 5),
          Text(date, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _alarmItem(String title, String subtitle, IconData iconData, bool isActive, Function(bool) onToggle) {
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
          Icon(iconData, color: Colors.purple.shade300),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
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
