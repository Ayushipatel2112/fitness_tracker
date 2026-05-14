import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1D1617);
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF7F8F8),
      appBar: AppBar(
        title: Text('Platform Analytics', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatGrid(),
            const SizedBox(height: 30),
            _buildChartSection('User Growth', _buildUserGrowthChart()),
            const SizedBox(height: 20),
            _buildChartSection('Activity Breakdown', _buildActivityPieChart()),
            const SizedBox(height: 20),
            _buildRecentActivityList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatGrid() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> userSnap) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('workouts').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> workoutSnap) {
            int userCount = userSnap.hasData ? userSnap.data!.docs.length : 0;
            int workoutCount = workoutSnap.hasData ? workoutSnap.data!.docs.length : 0;

            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.1,
              children: [
                _buildStatCard('Total Users', userCount.toString(), Icons.people_outline, const Color(0xFFFFA07A), const Color(0xFFFF6347)),
                _buildStatCard('Workouts', workoutCount.toString(), Icons.fitness_center_outlined, const Color(0xFFFFD194), const Color(0xFFD1913C)),
                _buildStatCard('Active Now', '12', Icons.bolt_rounded, const Color(0xFFF794A4), const Color(0xFFF25C7E)),
                _buildStatCard('Platform Value', '\$1.2k', Icons.monetization_on_outlined, const Color(0xFFECADFF), const Color(0xFFA18CD1)),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color1, Color color2) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color1, color2], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: color2.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildChartSection(String title, Widget chart) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1D1617))),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(height: 220, child: chart),
        ],
      ),
    );
  }

  Widget _buildUserGrowthChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (v) => FlLine(color: Colors.grey.withOpacity(0.1), strokeWidth: 1)),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30, getTitlesWidget: (v, m) {
            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
            if (v.toInt() < months.length) return Text(months[v.toInt()], style: const TextStyle(color: Colors.grey, fontSize: 10));
            return const Text('');
          })),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [FlSpot(0, 3), FlSpot(1, 5), FlSpot(2, 4), FlSpot(3, 8), FlSpot(4, 6), FlSpot(5, 10)],
            isCurved: true,
            color: const Color(0xFFD67078),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(colors: [const Color(0xFFD67078).withOpacity(0.15), const Color(0xFFD67078).withOpacity(0.01)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(color: const Color(0xFFE89344).withOpacity(0.8), value: 40, title: '40%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          PieChartSectionData(color: const Color(0xFFD67078).withOpacity(0.8), value: 30, title: '30%', radius: 45, titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          PieChartSectionData(color: const Color(0xFF5A9BD5).withOpacity(0.8), value: 20, title: '20%', radius: 40, titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          PieChartSectionData(color: const Color(0xFF42A385).withOpacity(0.8), value: 10, title: '10%', radius: 35, titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRecentActivityList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Platform Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1D1617))),
              Text('See All', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildActivityTile('New User Registered', 'Just now', Icons.person_add_rounded, const Color(0xFF92A3FD)),
        _buildActivityTile('Workout Logged', '5 mins ago', Icons.fitness_center_rounded, const Color(0xFFC58BF2)),
        _buildActivityTile('Large Meal Logged', '12 mins ago', Icons.restaurant_rounded, const Color(0xFFEEA4CE)),
        _buildActivityTile('New Feedback', '1 hour ago', Icons.chat_bubble_outline_rounded, const Color(0xFF9DCEFF)),
      ],
    );
  }

  Widget _buildActivityTile(String title, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1D1617))),
                const SizedBox(height: 5),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 14),
        ],
      ),
    );
  }
}
