import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/custom_button.dart';
import '../globals.dart' as globals;

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                "assets/images/success_celebration.png",
                height: 300,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.check_circle,
                  size: 200,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Welcome, ${globals.currentUserFirstName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'You are all set now, let’s reach your goals together with us!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray1, fontSize: 12),
              ),
              const Spacer(),
              CustomButton(
                text: 'Go To Home',
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
