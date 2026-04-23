import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/profile_info.png',
                  height: 300,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person_pin_outlined,
                    size: 200,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Let\'s complete your profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'It will help us to know more about you',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.gray1),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Weight (KG)',
                        prefixIcon: Icons.monitor_weight_outlined,
                        controller: _weightController,
                        validator: (value) => value!.isEmpty ? 'Enter weight' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Height (CM)',
                        prefixIcon: Icons.height_outlined,
                        controller: _heightController,
                        validator: (value) => value!.isEmpty ? 'Enter height' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Age (Years)',
                        prefixIcon: Icons.calendar_today_outlined,
                        controller: _ageController,
                        validator: (value) => value!.isEmpty ? 'Enter age' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/goal_selection');
                    }
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
