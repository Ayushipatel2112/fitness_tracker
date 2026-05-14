import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Services')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text('Our Services',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _ServiceCard(
            title: 'Workout Plans',
            description:
                'Follow beginner-friendly exercise routines for strength and endurance.',
            icon: Icons.fitness_center,
          ),
          _ServiceCard(
            title: 'Meal Plans',
            description: 'Get easy meal ideas and simple nutrition guidance.',
            icon: Icons.restaurant_menu,
          ),
          _ServiceCard(
            title: 'Sleep Coaching',
            description: 'Track your sleep and improve your nightly recovery.',
            icon: Icons.bedtime,
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _ServiceCard(
      {required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFF6D4BFF).withOpacity(0.14),
              child: Icon(icon, color: const Color(0xFF6D4BFF), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(description,
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
