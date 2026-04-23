import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int _selectedPeriod = 0; // 0: Weekly, 1: Monthly, 2: All Time

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Leaderboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Period Selector
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                _periodTab('Weekly', 0),
                _periodTab('Monthly', 1),
                _periodTab('All Time', 2),
              ],
            ),
          ),

          // Top 3 Podium
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _podiumCard(2, 'Sarah M.', '8,450', 160, Colors.grey),
                const SizedBox(width: 10),
                _podiumCard(1, 'John D.', '12,340', 200, const Color(0xFFFFD700)),
                const SizedBox(width: 10),
                _podiumCard(3, 'Mike R.', '7,890', 140, const Color(0xFFCD7F32)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Leaderboard List
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _leaderboardItem(4, 'Emma W.', '7,120', 'assets/images/app_logo.png'),
                  _leaderboardItem(5, 'David L.', '6,890', 'assets/images/app_logo.png'),
                  _leaderboardItem(6, 'Lisa K.', '6,450', 'assets/images/app_logo.png'),
                  _leaderboardItem(7, 'Tom H.', '6,120', 'assets/images/app_logo.png'),
                  _leaderboardItem(8, 'Anna P.', '5,980', 'assets/images/app_logo.png'),
                  _leaderboardItem(9, 'Chris B.', '5,760', 'assets/images/app_logo.png'),
                  _leaderboardItem(10, 'Nina S.', '5,540', 'assets/images/app_logo.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _periodTab(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPeriod = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _selectedPeriod == index
                ? const Color(0xFF92A3FD)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _selectedPeriod == index
                  ? Colors.white
                  : Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _podiumCard(int rank, String name, String points, double height, Color color) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.2),
              border: Border.all(color: color, width: 3),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$points pts',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leaderboardItem(int rank, String name, String points, String avatar) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFF92A3FD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF92A3FD),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            '$points pts',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF92A3FD),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
