import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

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
          'Our Services',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Transform Your Fitness Journey',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Choose the perfect plan for your goals',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 30),

            // Service Cards
            _serviceCard(
              'Personal Training',
              'One-on-one coaching with certified trainers',
              Icons.person,
              const Color(0xFF92A3FD),
              [
                'Customized workout plans',
                'Weekly progress tracking',
                'Nutrition guidance',
                'Video call sessions',
              ],
            ),
            _serviceCard(
              'Meal Planning',
              'Personalized nutrition plans for your goals',
              Icons.restaurant_menu,
              const Color(0xFFC58BF2),
              [
                'Custom meal plans',
                'Calorie tracking',
                'Recipe suggestions',
                'Shopping lists',
              ],
            ),
            _serviceCard(
              'Workout Programs',
              'Structured programs for all fitness levels',
              Icons.fitness_center,
              const Color(0xFF92A3FD),
              [
                'Beginner to advanced',
                'Home & gym workouts',
                'Video demonstrations',
                'Progress tracking',
              ],
            ),
            _serviceCard(
              'Group Classes',
              'Join live and recorded fitness classes',
              Icons.groups,
              const Color(0xFFC58BF2),
              [
                'Live streaming classes',
                'On-demand library',
                'Various workout styles',
                'Community support',
              ],
            ),
            _serviceCard(
              'Sleep Tracking',
              'Monitor and improve your sleep quality',
              Icons.bedtime,
              const Color(0xFF92A3FD),
              [
                'Sleep pattern analysis',
                'Quality metrics',
                'Improvement tips',
                'Bedtime reminders',
              ],
            ),
            _serviceCard(
              'Progress Analytics',
              'Detailed insights into your fitness journey',
              Icons.analytics,
              const Color(0xFFC58BF2),
              [
                'Body measurements',
                'Photo comparisons',
                'Performance graphs',
                'Goal tracking',
              ],
            ),
            const SizedBox(height: 20),

            // CTA Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF92A3FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Get Started Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceCard(
    String title,
    String description,
    IconData icon,
    Color color,
    List<String> features,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 10),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: color, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      feature,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
