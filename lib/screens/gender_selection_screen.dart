import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/custom_button.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/gender_selection.png',
                height: 300,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.people_outline,
                  size: 200,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Help us know you more',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'It will help us to know which programs are best for you',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.gray1),
              ),
              const SizedBox(height: 30),
              _genderOption('Male', Icons.male),
              const SizedBox(height: 15),
              _genderOption('Female', Icons.female),
              const Spacer(),
              CustomButton(
                text: 'Next',
                onPressed: () {
                  Navigator.pushNamed(context, '/profile_info');
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _genderOption(String gender, IconData icon) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: isSelected ? const LinearGradient(colors: AppColors.primaryGradient) : null,
          color: isSelected ? null : AppColors.border,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.white : AppColors.gray1,
            ),
            const SizedBox(width: 15),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.gray1,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.white)
            else
              const Icon(Icons.circle_outlined, color: AppColors.gray1),
          ],
        ),
      ),
    );
  }
}
