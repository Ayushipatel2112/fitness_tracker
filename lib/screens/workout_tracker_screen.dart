import 'package:flutter/material.dart';
import 'workout_schedule_screen.dart';
import 'workout_details_screen.dart';

class WorkoutTrackerScreen extends StatelessWidget {
  const WorkoutTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Workout Tracker', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(child: Text('Chart Component Placeholder', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            const SizedBox(height: 25),
            
            // Daily Workout Schedule
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF92A3FD).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Daily Workout Schedule', style: TextStyle(fontWeight: FontWeight.w600)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutScheduleScreen()));
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

            const SizedBox(height: 25),
            
            // Upcoming Workout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Upcoming Workout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('See more', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 15),
            _workoutItem('Fullbody Workout', 'Today, 03:00pm', true),
            _workoutItem('Upperbody Workout', 'June 05, 02:00pm', false),
            
            const SizedBox(height: 25),
            const Text('What Do You Want to Train', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            
            _trainingOption(context, 'Fullbody Workout', '11 Exercises | 32mins', Colors.blue.withOpacity(0.1)),
            _trainingOption(context, 'Lowerbody Workout', '12 Exercises | 40mins', Colors.blue.withOpacity(0.1)),
            _trainingOption(context, 'AB Workout', '14 Exercises | 20mins', Colors.blue.withOpacity(0.1)),
          ],
        ),
      ),
    );
  }

  Widget _workoutItem(String title, String time, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.blue.withOpacity(0.2), child: const Icon(Icons.fitness_center, color: Colors.blue)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 5),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Switch(value: isActive, onChanged: (v) {}, activeColor: Colors.purple.shade300),
        ],
      ),
    );
  }
  
  Widget _trainingOption(BuildContext context, String title, String desc, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => const WorkoutDetailsScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('View more', style: TextStyle(color: Color(0xFF92A3FD), fontSize: 12)),
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.sports_gymnastics, size: 40, color: Color(0xFF92A3FD)),
          ),
        ],
      ),
    );
  }
}
