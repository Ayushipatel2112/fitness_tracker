import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blog')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text('Fitness Blog',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _BlogCard(
            title: 'Healthy habits for beginners',
            subtitle: 'Learn how to build a simple fitness routine that lasts.',
          ),
          _BlogCard(
            title: 'Meal ideas for daily energy',
            subtitle: 'Easy nutrition tips to keep you fueled all day.',
          ),
          _BlogCard(
            title: 'How to improve your sleep',
            subtitle: 'Fix your routine and recover better every night.',
          ),
        ],
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _BlogCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Read more'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
