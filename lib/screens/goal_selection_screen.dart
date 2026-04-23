import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({super.key});

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  int selectedGoalIndex = 0;

  final PageController _pageController = PageController(viewportFraction: 0.75);

  final List<Map<String, String>> goals = [
    {
      'title': 'Improve Shape',
      'desc':
          'I have a low amount of body fat and need / want to build more muscle',
      'image': 'assets/images/improve_shape.png',
    },
    {
      'title': 'Lean & Tone',
      'desc':
          'I’m “skinny fat”. look thin but have no shape. I want to add learn muscle in the right way',
      'image': 'assets/images/learn_tone.png',
    },
    {
      'title': 'Lose a Fat',
      'desc':
          'I have over 20 kg overweight. I want to lose all this fat and gain muscle mass',
      'image': 'assets/images/loss_fat.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background white rakhein
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'What is your goal?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'It will help us to choose a best program for you',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.6, // Card ki height set ki
              child: PageView.builder(
                controller: _pageController,
                itemCount: goals.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedGoalIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _goalCard(goals[index], index == selectedGoalIndex);
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                text: 'Confirm',
                onPressed: () {
                  Navigator.pushNamed(context, '/success');
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _goalCard(Map<String, String> goal, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        // Screenshot ke exact gradient colors
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
        ),
        borderRadius: BorderRadius.circular(30), // Zyada round corners
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF92A3FD).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(
                goal['image']!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.fitness_center,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Text(
            goal['title']!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          // Title ke niche wali white line
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 15),
            height: 1.5,
            width: 50,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Text(
              goal['desc']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                height: 1.5, // Line spacing ke liye
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
