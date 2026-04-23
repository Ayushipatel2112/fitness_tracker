import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'workout_tracker_screen.dart';
import 'meal_tracker_screen.dart';
import 'sleep_tracker_screen.dart';

// DashboardScreen shows the bottom navigation bar.
// It switches between pages when the user taps the bottom icons.
// This uses StatefulWidget because we need to track which tab is selected.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // This variable stores which tab is currently open
  // 0 = Home, 1 = Workout, 2 = Meal, 3 = Sleep, 4 = Profile
  int _selectedIndex = 0;

  // These are the pages shown when each tab is tapped
  final List<Widget> _pages = [
    const HomeScreen(),           // Tab 0 - Home
    const WorkoutTrackerScreen(), // Tab 1 - Workout
    const MealTrackerScreen(),    // Tab 2 - Meal
    const SleepTrackerScreen(),   // Tab 3 - Sleep
    const ProfileScreen(),        // Tab 4 - Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Shows the page that matches the selected tab number
      body: _pages[_selectedIndex],

      // Bottom navigation bar with 4 icon buttons
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // notch for the floating button
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home button
            IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: _selectedIndex == 0 ? AppColors.primary : AppColors.gray1,
              ),
              onPressed: () => setState(() => _selectedIndex = 0),
            ),

            // Workout button
            IconButton(
              icon: Icon(
                Icons.bar_chart_outlined,
                color: _selectedIndex == 1 ? AppColors.primary : AppColors.gray1,
              ),
              onPressed: () => setState(() => _selectedIndex = 1),
            ),

            // Empty space for the center floating button
            const SizedBox(width: 40),

            // Meal button
            IconButton(
              icon: Icon(
                Icons.restaurant_outlined,
                color: _selectedIndex == 2 ? AppColors.primary : AppColors.gray1,
              ),
              onPressed: () => setState(() => _selectedIndex = 2),
            ),

            // Profile button
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: _selectedIndex == 4 ? AppColors.primary : AppColors.gray1,
              ),
              onPressed: () => setState(() => _selectedIndex = 4),
            ),
          ],
        ),
      ),

      // Center floating action button - opens Sleep Tracker
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _selectedIndex = 3),
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.search, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
