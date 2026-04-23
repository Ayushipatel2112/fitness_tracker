import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/step_progress_button.dart';

class Intro1Screen extends StatelessWidget {
  const Intro1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white, 
      body: Column(
        children: [
          
          Container(
            height: screenSize.height * 0.55, 
            width: double.infinity,
            decoration: const BoxDecoration(
              color:
                  Color(0xFFE9EEFF), 
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                    80), 
                bottomRight: Radius.circular(80),
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/images/track_goal.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.track_changes,
                      size: 150,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Track Your Goal',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Poppins', 
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(), 

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: StepProgressButton(
                        progress: 0.25,
                        onPressed: () {
                          Navigator.pushNamed(context, '/intro2');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
