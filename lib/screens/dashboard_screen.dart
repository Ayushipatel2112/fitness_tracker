import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_screen.dart';
import 'workouts_screen.dart';
import 'meals_screen.dart';
import 'sleep_screen.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  String get userName {
    final displayName = FirebaseAuth.instance.currentUser?.displayName;
    return displayName != null && displayName.isNotEmpty ? displayName : 'User';
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutsScreen()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MealsScreen()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SleepScreen()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1D1617);
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // User Side Abstract Background Shapes
          Positioned(
            top: -150,
            right: -100,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                  color: const Color(0xFF9DCEFF).withOpacity(isDark ? 0.04 : 0.08),
                  shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -120,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                  color: const Color(0xFFEEA4CE).withOpacity(isDark ? 0.03 : 0.05),
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildBMICard(),
                  const SizedBox(height: 30),
                  _buildTodayTarget(),
                  const SizedBox(height: 30),
                  Text(
                    'Activity Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                  ),
                  const SizedBox(height: 15),
                  _buildHeartRateCard(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: _buildWaterIntakeCard()),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          children: [
                            _buildSleepCard(),
                            const SizedBox(height: 15),
                            _buildCaloriesCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Workout Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9DCEFF).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Text('Weekly', style: TextStyle(color: Color(0xFF9DCEFF), fontWeight: FontWeight.bold, fontSize: 12)),
                            Icon(Icons.keyboard_arrow_down, color: Color(0xFF9DCEFF), size: 16),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildWorkoutProgressChart(),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Latest Workout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
                      const Text('See more', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildLatestWorkoutList(),
                  const SizedBox(height: 80), // padding for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).cardColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center_outlined), activeIcon: Icon(Icons.fitness_center), label: 'Workout'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_outlined), activeIcon: Icon(Icons.restaurant), label: 'Meals'),
          BottomNavigationBarItem(icon: Icon(Icons.bedtime_outlined), activeIcon: Icon(Icons.bedtime), label: 'Sleep'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome Back,', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          ],
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              builder: (context) => Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const CircleAvatar(backgroundColor: Color(0xFF9DCEFF), child: Icon(Icons.notifications, color: Colors.white)),
                      title: Text('New Challenge Available!', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                      subtitle: const Text('Check out the Heavy Lifter challenge.', style: TextStyle(color: Colors.grey)),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: const CircleAvatar(backgroundColor: Color(0xFFC58BF2), child: Icon(Icons.restaurant, color: Colors.white)),
                      title: Text('Lunch Time!', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                      subtitle: const Text('Don\'t forget to log your meal.', style: TextStyle(color: Colors.grey)),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
            ),
            child: Icon(Icons.notifications_none, size: 20, color: isDark ? Colors.white : Colors.black),
          ),
        )
      ],
    );
  }

  Widget _buildBMICard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9DCEFF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('BMI (Body Mass Index)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                const Text('You have a normal weight', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEEA4CE), Color(0xFFC58BF2)],
                    ),
                  ),
                  child: const Text('View More', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 30,
                    sections: [
                      PieChartSectionData(color: Colors.white, value: 70, radius: 10, showTitle: false),
                      PieChartSectionData(color: const Color(0xFFC58BF2), value: 30, radius: 10, showTitle: false),
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                  String bmiText = '20.1';
                  if (snap.hasData && snap.data!.docs.isNotEmpty) {
                    var data = snap.data!.docs.first.data() as Map<String, dynamic>;
                    if (data['height'] != null && data['weight'] != null) {
                      double h = double.tryParse(data['height'].toString()) ?? 180;
                      double w = double.tryParse(data['weight'].toString()) ?? 65;
                      if (h > 0) {
                        double bmi = w / ((h/100) * (h/100));
                        bmiText = bmi.toStringAsFixed(1);
                      }
                    }
                  }
                  return Text(bmiText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
                }
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTodayTarget() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF9DCEFF).withOpacity(isDark ? 0.1 : 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Today Target', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).cardColor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Total Activity Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                        const SizedBox(height: 20),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('workouts').snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                            int count = snap.hasData ? snap.data!.docs.length : 0;
                            return ListTile(
                              leading: const Icon(Icons.fitness_center, color: Color(0xFF9DCEFF)),
                              title: Text('Workouts Logged', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                              subtitle: Text('$count total workouts completed', style: const TextStyle(color: Colors.grey)),
                            );
                          }
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('meals').snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                            int count = snap.hasData ? snap.data!.docs.length : 0;
                            return ListTile(
                              leading: const Icon(Icons.restaurant, color: Color(0xFFC58BF2)),
                              title: Text('Meals Logged', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                              subtitle: Text('$count total meals tracked', style: const TextStyle(color: Colors.grey)),
                            );
                          }
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('sleep').snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                            int count = snap.hasData ? snap.data!.docs.length : 0;
                            return ListTile(
                              leading: const Icon(Icons.bedtime, color: Color(0xFF92A3FD)),
                              title: Text('Sleep Logged', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                              subtitle: Text('$count total sleep records saved', style: const TextStyle(color: Colors.grey)),
                            );
                          }
                        ),
                      ],
                    ),
                  );
                }
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                ),
              ),
              child: const Text('Check', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeartRateCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFEEA4CE).withOpacity(isDark ? 0.1 : 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Heart Rate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
          Text('${70 + DateTime.now().minute % 20} BPM', style: const TextStyle(color: Color(0xFF9DCEFF), fontWeight: FontWeight.bold, fontSize: 18)),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3), FlSpot(1, 1), FlSpot(2, 4), FlSpot(3, 2),
                      FlSpot(4, 5), FlSpot(5, 1), FlSpot(6, 4),
                    ],
                    isCurved: true,
                    color: const Color(0xFF9DCEFF),
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF9DCEFF).withOpacity(0.2),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWaterIntakeCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 315,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF9DCEFF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Water Intake', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
                const Text('4 Liters', style: TextStyle(color: Color(0xFF9DCEFF), fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                const Text('Realtime updates', style: TextStyle(color: Colors.grey, fontSize: 10)),
                const SizedBox(height: 10),
                _buildTimelineItem('6am - 8am', '600ml', true),
                _buildTimelineItem('9am - 11am', '500ml', true),
                _buildTimelineItem('11am - 2pm', '1000ml', false),
                _buildTimelineItem('2pm - 4pm', '700ml', false),
                _buildTimelineItem('4pm - now', '900ml', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String time, String amount, bool isPast) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(time, style: TextStyle(color: isPast ? Colors.grey : (isDark ? Colors.white70 : Colors.black54), fontSize: 10)),
          Text(amount, style: TextStyle(color: isPast ? const Color(0xFFC58BF2) : (isDark ? Colors.white : Colors.black87), fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSleepCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sleep', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('sleep').where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
              String sleepText = '0h 0m';
              if (snap.hasData && snap.data!.docs.isNotEmpty) {
                var latest = snap.data!.docs.first.data() as Map<String, dynamic>;
                sleepText = '${latest['hoursSlept'] ?? 0} hrs';
              }
              return Text(sleepText, style: const TextStyle(color: Color(0xFF9DCEFF), fontWeight: FontWeight.bold, fontSize: 16));
            }
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [FlSpot(0, 2), FlSpot(1, 3), FlSpot(2, 1), FlSpot(3, 4)],
                    isCurved: true,
                    color: const Color(0xFF9DCEFF),
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCaloriesCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Calories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('workouts').where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
              int totalCals = 0;
              if (snap.hasData) {
                for (var doc in snap.data!.docs) {
                  var data = doc.data() as Map<String, dynamic>;
                  totalCals += int.tryParse(data['caloriesBurned']?.toString() ?? '0') ?? 0;
                }
              }
              return Text('$totalCals kCal', style: const TextStyle(color: Color(0xFF9DCEFF), fontWeight: FontWeight.bold, fontSize: 16));
            }
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    value: 0.7,
                    strokeWidth: 8,
                    backgroundColor: isDark ? Colors.white10 : Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC58BF2)),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text('230kCal\nleft', textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: isDark ? Colors.white70 : Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorkoutProgressChart() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 200,
      padding: const EdgeInsets.all(10),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(days[value.toInt()], style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}%', style: const TextStyle(color: Colors.grey, fontSize: 10));
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 20,
            getDrawingHorizontalLine: (value) => FlLine(color: isDark ? Colors.white10 : Colors.grey.shade200, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 40, color: const Color(0xFF9DCEFF), width: 8, borderRadius: BorderRadius.circular(10))]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 70, color: const Color(0xFF9DCEFF), width: 8, borderRadius: BorderRadius.circular(10))]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 30, color: const Color(0xFF9DCEFF), width: 8, borderRadius: BorderRadius.circular(10))]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 50, color: const Color(0xFF9DCEFF), width: 8, borderRadius: BorderRadius.circular(10))]),
            BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 90, color: const Color(0xFF9DCEFF), width: 8, borderRadius: BorderRadius.circular(10))]),
            BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 60, color: const Color(0xFF9DCEFF), width: 8, borderRadius: BorderRadius.circular(10))]),
            BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 80, color: const Color(0xFF9DCEFF), width: 8, borderRadius: BorderRadius.circular(10))]),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestWorkoutList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('workouts').where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        var docs = snap.data!.docs.toList();
        docs.sort((a,b) {
          Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp.now();
          Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp.now();
          return t2.compareTo(t1);
        });
        
        if (docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Text('No workouts logged yet.', style: TextStyle(color: Colors.grey))),
          );
        }
        
        return Column(
          children: docs.take(3).map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return Column(
              children: [
                _buildWorkoutTile(
                  data['exerciseName'] ?? 'Workout', 
                  '${data['caloriesBurned'] ?? 0} Calories | ${data['duration'] ?? 0} mins', 
                  'assets/images/fullbody_workout.png'
                ),
                const SizedBox(height: 15),
              ]
            );
          }).toList(),
        );
      }
    );
  }

  Widget _buildWorkoutTile(String title, String subtitle, String imagePath) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF9DCEFF).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Image.asset(imagePath, fit: BoxFit.contain, errorBuilder: (c,e,s) => const Icon(Icons.fitness_center, color: Color(0xFF9DCEFF))),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
