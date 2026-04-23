import 'package:flutter/material.dart';
import 'add_workout_schedule_screen.dart';

class WorkoutScheduleScreen extends StatelessWidget {
  const WorkoutScheduleScreen({super.key});

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
        title: const Text('Workout Schedule', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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
            // Calendar Month/Scroller placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
                SizedBox(width: 15),
                Text('May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                SizedBox(width: 15),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 20),
            
            // Days Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _dayItem('Tue', '11', false),
                  _dayItem('Wed', '12', false),
                  _dayItem('Thu', '13', false),
                  _dayItem('Fri', '14', true),
                  _dayItem('Sat', '15', false),
                  _dayItem('Sun', '16', false),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Timeline
            Stack(
              children: [
                Column(
                  children: [
                    _timelineRow('06:00 AM'),
                    _timelineRow('07:00 AM'),
                    _timelineRow('08:00 AM'),
                    _timelineRow('09:00 AM'),
                    _timelineRow('10:00 AM'),
                    _timelineRow('11:00 AM'),
                    _timelineRow('12:00 PM'),
                    _timelineRow('01:00 PM'),
                    _timelineRow('02:00 PM'),
                    _timelineRow('03:00 PM'),
                    _timelineRow('04:00 PM'),
                    _timelineRow('05:00 PM'),
                  ],
                ),
                
                // Blocks
                Positioned(
                  top: 75,
                  right: 20,
                  child: _scheduleBlock('Ab Workout, 7:30am', Colors.purple.shade100, Colors.purple.shade500),
                ),
                Positioned(
                  top: 175,
                  left: 60,
                  child: _scheduleBlock('Upperbody Workout, 9am', Colors.purple.shade100, Colors.purple.shade500),
                ),
                Positioned(
                  top: 475,
                  left: 80,
                  child: GestureDetector(
                    onTap: () {
                      _showActionDialog(context);
                    },
                    child: _scheduleBlock('Lowerbody Workout, 3pm', Colors.grey.shade100, Colors.black87),
                  ),
                ),
                
                // Current time line
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Container(height: 1, width: 60, color: Colors.blue),
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
                      Expanded(child: Container(height: 1, color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => const AddWorkoutScheduleScreen()));
        },
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _dayItem(String day, String date, bool isActive) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: isActive ? const LinearGradient(colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)]) : null,
        color: !isActive ? Colors.grey.shade50 : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(day, style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          Text(date, style: TextStyle(color: isActive ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _timelineRow(String time) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12))),
          Expanded(child: Container(height: 1, color: Colors.grey.shade200)),
        ],
      ),
    );
  }

  Widget _scheduleBlock(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  void _showActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Workout Schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => Navigator.pop(c)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lowerbody Workout', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(
              children: const [
                Icon(Icons.access_time, size: 14, color: Colors.grey),
                SizedBox(width: 5),
                Text('Today | 03:00PM', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(c),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF92A3FD),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                child: const Text('Mark as Done', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
