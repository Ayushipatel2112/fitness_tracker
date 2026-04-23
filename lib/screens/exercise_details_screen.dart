import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/custom_button.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.play_circle_fill, size: 80, color: AppColors.primary),
            ),
            const SizedBox(height: 30),
            const Text(
              'Jumping Jack',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Easy | 390 Calories Burn',
              style: TextStyle(color: AppColors.gray1, fontSize: 12),
            ),
            const SizedBox(height: 30),
            const Text('Descriptions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            const Text(
              'A jumping jack, also known as a star jump and called a side-straddle hop in the US military, is a physical jumping exercise performed by jumping to a position with the legs spread wide and the hands touching overhead, sometimes with a clap, and then returning to a position with the feet together and the arms at the sides.',
              style: TextStyle(color: AppColors.gray1, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 30),
            const Text('How To Do It', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _stepItem('01', 'Spread your arms', 'To make the movement of the legs and arms to be harmonious, first spread your arms...'),
            _stepItem('02', 'Rest at basic position', 'After reaching the top position, then return to the basic position of standing...'),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Save',
              onPressed: () {
                Navigator.pushNamed(context, '/congratulations');
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _stepItem(String number, String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: const TextStyle(color: AppColors.primaryShade, fontWeight: FontWeight.bold)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                Text(desc, style: const TextStyle(color: AppColors.gray1, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
