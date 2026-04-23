import 'package:flutter/material.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

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
        title: const Text('Achievement', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _buildAchievementCard('First Workout', 'Completed!', Icons.fitness_center, Colors.blue),
          _buildAchievementCard('7 Days Streak', 'Keep it up', Icons.local_fire_department, Colors.orange),
          _buildAchievementCard('10k Steps', 'Awesome', Icons.directions_walk, Colors.green),
          _buildAchievementCard('Lost 5kg', 'Goal Reached', Icons.emoji_events, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(String title, String subtitle, IconData icon, Color badgeColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [badgeColor.withOpacity(0.4), badgeColor.withOpacity(0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: badgeColor, size: 40),
          ),
          const SizedBox(height: 15),
          Text(
            title, 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey.shade800),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            subtitle, 
            style: TextStyle(color: badgeColor.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
