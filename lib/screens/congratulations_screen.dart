import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/custom_button.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/congratulations.png',
                height: 300,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.emoji_events_outlined,
                  size: 200,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Congratulations, You Have Finished Your Workout',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                'Exercises is king and nutrition is queen. Combine the two and you will have a kingdom',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray1, fontSize: 12),
              ),
              const SizedBox(height: 10),
              const Text(
                '-Jack Lalanne',
                style: TextStyle(color: AppColors.gray1, fontSize: 12),
              ),
              const Spacer(),
              CustomButton(
                text: 'Back To Home',
                onPressed: () {
                   Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
