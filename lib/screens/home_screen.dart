import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'activity_tracker_screen.dart';
import 'progress_photo_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'workout_tracker_screen.dart';
import 'sleep_tracker_screen.dart';
import 'meal_tracker_screen.dart';
import '../globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back,',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        globals.currentUserName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none,
                          color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationsScreen()));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // BMI Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'BMI (Body Mass Index)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'You have a normal weight',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade300,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            child: const Text(
                              'View More',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Center(
                        child: Text(
                          '20.1',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.purple),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Today Target Container
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF92A3FD).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today Target',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ActivityTrackerScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF92A3FD),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Check',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              const Text('Activity Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),

              // Activity Status Chart Placeholder
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF92A3FD).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Heart Rate',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const Text('78 BPM',
                        style: TextStyle(
                            color: Color(0xFF92A3FD),
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(height: 10),
                    Icon(Icons.monitor_heart,
                        size: 50,
                        color: const Color(0xFF92A3FD).withOpacity(0.5)),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Water Intake and Sleep Row
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MealTrackerScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Water Intake',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                            const SizedBox(height: 5),
                            const Text('4 Liters',
                                style: TextStyle(
                                    color: Color(0xFF92A3FD),
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15),
                            Container(
                                height: 60,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF92A3FD),
                                    borderRadius: BorderRadius.circular(10))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SleepTrackerScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Sleep',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                SizedBox(height: 5),
                                Text('8h 20m',
                                    style: TextStyle(
                                        color: Color(0xFF92A3FD),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MealTrackerScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Calories',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                SizedBox(height: 5),
                                Text('760 kCal',
                                    style: TextStyle(
                                        color: Color(0xFF92A3FD),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Workout Progress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Workout Progress',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xFF92A3FD),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: const [
                        Text('Weekly',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Icon(Icons.keyboard_arrow_down,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkoutTrackerScreen())),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.only(right: 20, top: 20, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 5))
                    ],
                  ),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: 6,
                      minY: 0,
                      maxY: 6,
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 3),
                            FlSpot(1, 1),
                            FlSpot(2, 4),
                            FlSpot(3, 2),
                            FlSpot(4, 5),
                            FlSpot(5, 3),
                            FlSpot(6, 4),
                          ],
                          isCurved: true,
                          color: const Color(0xFF92A3FD),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color(0xFF92A3FD).withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Latest Workout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Latest Workout',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const WorkoutTrackerScreen())),
                    child: Text('See more',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _workoutItem('Fullbody Workout', '180 Calories Burn | 20minutes',
                  Icons.fitness_center),
              _workoutItem('Lowerbody Workout', '200 Calories Burn | 30minutes',
                  Icons.directions_run),
              _workoutItem('Ab Workout', '150 Calories Burn | 15minutes',
                  Icons.sports_gymnastics),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF92A3FD),
        elevation: 0,
        child: const Icon(Icons.search, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: Icon(Icons.home,
                    color: _selectedIndex == 0
                        ? Colors.purple.shade300
                        : Colors.grey),
                onPressed: () => setState(() => _selectedIndex = 0)),
            IconButton(
                icon: Icon(Icons.show_chart,
                    color: _selectedIndex == 1
                        ? Colors.purple.shade300
                        : Colors.grey),
                onPressed: () {
                  setState(() => _selectedIndex = 1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ActivityTrackerScreen()));
                }),
            const SizedBox(width: 40),
            IconButton(
                icon: Icon(Icons.camera_alt,
                    color: _selectedIndex == 2
                        ? Colors.purple.shade300
                        : Colors.grey),
                onPressed: () {
                  setState(() => _selectedIndex = 2);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProgressPhotoScreen()));
                }),
            IconButton(
                icon: Icon(Icons.person,
                    color: _selectedIndex == 3
                        ? Colors.purple.shade300
                        : Colors.grey),
                onPressed: () {
                  setState(() => _selectedIndex = 3);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                }),
          ],
        ),
      ),
    );
  }

  Widget _workoutItem(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              radius: 25,
              child: Icon(icon, color: Colors.blue.shade200)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 5),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5))),
                    Container(
                        height: 10,
                        width: 150,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade200,
                              Colors.purple.shade400
                            ]),
                            borderRadius: BorderRadius.circular(5))),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.purple.shade100)),
            child: Icon(Icons.arrow_forward_ios,
                size: 12, color: Colors.purple.shade200),
          ),
        ],
      ),
    );
  }
}
