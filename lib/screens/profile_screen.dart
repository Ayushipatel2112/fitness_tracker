import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/firebase_service.dart';
import 'login_screen.dart';
import '../theme/theme_provider.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactMessageController = TextEditingController();

  @override
  void dispose() {
    _contactNameController.dispose();
    _contactMessageController.dispose();
    super.dispose();
  }

  String get userName {
    final displayName = FirebaseAuth.instance.currentUser?.displayName;
    return displayName != null && displayName.isNotEmpty ? displayName : 'User';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final textColor = isDark ? Colors.white : Colors.black;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseService.userProfileStream(),
      builder: (context, snapshot) {
        Map<String, dynamic> userData = {};
        if (snapshot.hasData && snapshot.data!.exists) {
          userData = snapshot.data!.data() as Map<String, dynamic>;
        }

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Profile', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              // Profile Background Shapes
              Positioned(
                top: -120,
                right: -80,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(isDark ? 0.05 : 0.08),
                      shape: BoxShape.circle),
                ),
              ),
              Positioned(
                bottom: -100,
                left: -120,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                      color: AppColors.purpleAccent.withOpacity(isDark ? 0.03 : 0.05),
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(textColor, userData),
                    const SizedBox(height: 30),
                    _buildStatsRow(cardColor, userData),
                    const SizedBox(height: 30),
                    _buildSection(
                      title: 'Account',
                      cardColor: cardColor,
                      textColor: textColor,
                      items: [
                        _buildListItem(Icons.person_outline, 'Personal Data', AppColors.secondary, textColor),
                        _buildListItem(Icons.badge_outlined, 'Achievement', AppColors.secondary, textColor),
                        _buildListItem(Icons.history_outlined, 'Activity History', AppColors.secondary, textColor),
                        _buildListItem(Icons.bar_chart_outlined, 'Workout Progress', AppColors.secondary, textColor),
                      ],
                    ),
                    const SizedBox(height: 25),
                    _buildSection(
                      title: 'Notification',
                      cardColor: cardColor,
                      textColor: textColor,
                      items: [
                        _buildToggleItem(Icons.notifications_none_outlined, 'Pop-up Notification', AppColors.secondary, textColor),
                      ],
                    ),
                    const SizedBox(height: 25),
                    _buildSection(
                      title: 'Other',
                      cardColor: cardColor,
                      textColor: textColor,
                      items: [
                        _buildListItem(Icons.contact_support_outlined, 'Contact Us', AppColors.secondary, textColor),
                        _buildListItem(Icons.privacy_tip_outlined, 'Privacy Policy', AppColors.secondary, textColor),
                        _buildListItem(Icons.settings_outlined, 'Settings', AppColors.secondary, textColor),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                                    (route) => false);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.purpleAccent),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text('Logout',
                                style: TextStyle(color: AppColors.purpleAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildProfileHeader(Color textColor, Map<String, dynamic> userData) {
    String name = userData['fullName'] ?? userName;
    String program = userData['program'] ?? 'Lose a Fat Program';
    String? profilePic = userData['profilePicture'];

    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary,
          ),
          child: profilePic != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(profilePic, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.person, color: Colors.white, size: 30)),
                )
              : const Icon(Icons.person, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
              const SizedBox(height: 5),
              Text(program, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(appBar: AppBar(title: const Text('Edit Profile')), body: _buildEditProfilePage(context, userData))));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [AppColors.secondary, AppColors.primary],
              ),
            ),
            child: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Widget _buildStatsRow(Color cardColor, Map<String, dynamic> userData) {
    return Row(
      children: [
        Expanded(child: _buildStatCard('${userData['height'] ?? '--'}cm', 'Height', cardColor)),
        const SizedBox(width: 15),
        Expanded(child: _buildStatCard('${userData['weight'] ?? '--'}kg', 'Weight', cardColor)),
        const SizedBox(width: 15),
        Expanded(child: _buildStatCard('${userData['age'] ?? '--'}yo', 'Age', cardColor)),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color cardColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, spreadRadius: 5)],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items, required Color cardColor, required Color textColor}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, spreadRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
          const SizedBox(height: 15),
          ...items,
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, Color iconColor, Color textColor) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseService.userProfileStream(),
      builder: (context, snapshot) {
        Map<String, dynamic> userData = {};
        if (snapshot.hasData && snapshot.data!.exists) {
          userData = snapshot.data!.data() as Map<String, dynamic>;
        }

        return InkWell(
          onTap: () {
            if (!context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: title == 'Personal Data'
                      ? _buildEditProfilePage(context, userData)
                      : title == 'Leaderboard'
                      ? _buildLeaderboardPage()
                      : title == 'Fitness Challenges'
                      ? _buildChallengesPage()
                      : title == 'Contact Us'
                      ? _buildContactUsPage(context)
                      : title == 'Settings'
                      ? _buildSettingsPage()
                      : title == 'Privacy Policy'
                      ? _buildPrivacyPolicyPage()
                      : title == 'Workout Progress'
                      ? _buildWorkoutProgressPage()
                      : _buildGenericTextPage(title),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(width: 15),
                Expanded(child: Text(title, style: TextStyle(fontSize: 14, color: textColor))),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildToggleItem(IconData icon, String title, Color iconColor, Color textColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 15),
        Expanded(child: Text(title, style: TextStyle(fontSize: 14, color: textColor))),
        Switch(
          value: _notificationsEnabled,
          onChanged: (val) => setState(() => _notificationsEnabled = val),
          activeColor: AppColors.purpleAccent,
        ),
      ],
    );
  }

  Widget _buildWorkoutProgressPage() {
    final cardColor = Theme.of(context).cardColor;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.secondary, AppColors.primary]),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Real-time Progress', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 5),
                Text('You have burned 1,240 kcal this week!', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text('Calories Burnt (Weekly)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          Container(
            height: 200,
            padding: const EdgeInsets.only(right: 20, top: 20, left: 10),
            decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
                    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    return Text(days[v.toInt()], style: const TextStyle(fontSize: 10, color: Colors.grey));
                  })),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 45, color: AppColors.secondary, width: 12, borderRadius: BorderRadius.circular(6))]),
                  BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 80, color: AppColors.primary, width: 12, borderRadius: BorderRadius.circular(6))]),
                  BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 60, color: AppColors.purpleAccent, width: 12, borderRadius: BorderRadius.circular(6))]),
                  BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 90, color: AppColors.pinkAccent, width: 12, borderRadius: BorderRadius.circular(6))]),
                  BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 50, color: AppColors.secondary, width: 12, borderRadius: BorderRadius.circular(6))]),
                  BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 70, color: AppColors.primary, width: 12, borderRadius: BorderRadius.circular(6))]),
                  BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 30, color: AppColors.purpleAccent, width: 12, borderRadius: BorderRadius.circular(6))]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildActivityCard('Daily Steps', '8,432', 'Target: 10,000', Icons.directions_walk, AppColors.secondary),
          const SizedBox(height: 15),
          _buildActivityCard('Total Workouts', '12', 'This month', Icons.fitness_center, AppColors.purpleAccent),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, String val, String sub, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: color)),
          const SizedBox(width: 15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
          const Spacer(),
          Text(val, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)),
        ],
      ),
    );
  }

  Widget _buildSettingsPage() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        bool isDark = themeProvider.themeMode == ThemeMode.dark;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildSection(
              title: 'App Theme',
              cardColor: Theme.of(context).cardColor,
              textColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              items: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode'),
                    Switch(
                      value: isDark,
                      onChanged: (val) => themeProvider.toggleTheme(val),
                      activeColor: AppColors.purpleAccent,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPrivacyPolicyPage() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Privacy Policy', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text('Your privacy is important to us. This policy explains how we collect and protect your fitness data.', style: TextStyle(height: 1.5)),
          SizedBox(height: 15),
          Text('1. Data Security', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('We use industry-standard encryption to protect your records in our cloud database.'),
        ],
      ),
    );
  }

  Widget _buildChallengesPage() {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Special Challenges', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Join to earn exclusive badges!', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 20),
          _buildProChallengeCard('Full Body Shred', 'Complete 10 workouts in 7 days.', '1,240 joined', AppColors.primary, AppColors.secondary),
          _buildProChallengeCard('Morning Cardio', 'Run 5km every morning for a week.', '850 joined', AppColors.purpleAccent, AppColors.pinkAccent),
          _buildProChallengeCard('Water Master', 'Drink 4L water daily for 30 days.', '2,100 joined', Colors.blue, Colors.lightBlueAccent),
        ],
      ),
    );
  }

  Widget _buildProChallengeCard(String title, String desc, String joined, Color c1, Color c2) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [c1, c2], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: c1.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              const Icon(Icons.star, color: Colors.white, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(joined, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Joined $title Challenge!')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: c1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text('Start Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEditProfilePage(BuildContext context, Map<String, dynamic> userData) {
    final nameController = TextEditingController(text: userData['fullName'] ?? userName);
    final emailController = TextEditingController(text: userData['email'] ?? '');
    final phoneController = TextEditingController(text: userData['phone'] ?? '');
    final programController = TextEditingController(text: userData['program'] ?? 'Lose a Fat Program');
    final heightController = TextEditingController(text: userData['height']?.toString() ?? '');
    final weightController = TextEditingController(text: userData['weight']?.toString() ?? '');
    final ageController = TextEditingController(text: userData['age']?.toString() ?? '');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100, height: 100,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.secondary),
                child: userData['profilePicture'] != null 
                  ? ClipRRect(borderRadius: BorderRadius.circular(50), child: Image.network(userData['profilePicture'], fit: BoxFit.cover))
                  : const Icon(Icons.person, size: 50, color: Colors.white),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: CircleAvatar(
                  radius: 18, backgroundColor: AppColors.purpleAccent,
                  child: IconButton(icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white), onPressed: () {
                    // Integration with image_picker would go here
                  }),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          _buildPremiumTextField('Full Name', 'Enter your full name', nameController),
          _buildPremiumTextField('Email', 'Enter your email', emailController, enabled: false),
          _buildPremiumTextField('Phone', 'Enter phone number', phoneController),
          _buildPremiumTextField('Goal Program', 'e.g. Gain Muscle', programController),
          Row(
            children: [
              Expanded(child: _buildPremiumTextField('Height (cm)', '180', heightController, isNumber: true)),
              const SizedBox(width: 15),
              Expanded(child: _buildPremiumTextField('Weight (kg)', '65', weightController, isNumber: true)),
            ],
          ),
          _buildPremiumTextField('Age', '22', ageController, isNumber: true),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              onPressed: () async {
                Map<String, Object> updateData = {
                  'fullName': nameController.text.trim(),
                  'phone': phoneController.text.trim(),
                  'program': programController.text.trim(),
                  'height': heightController.text.trim(),
                  'weight': weightController.text.trim(),
                  'age': ageController.text.trim(),
                };
                final error = await FirebaseService.updateUserProfile(updateData);
                if (!context.mounted) return;
                if (error == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Updated Successfully!')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                }
              }, 
              child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumTextField(String label, String hint, TextEditingController controller, {bool enabled = true, bool isNumber = false}) {
    final cardColor = Theme.of(context).cardColor;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildLeaderboardPage() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').orderBy('fullName').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        var users = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: users.length,
          itemBuilder: (context, index) {
            var data = users[index].data() as Map<String, dynamic>;
            return _buildLeaderboardTile(index + 1, data['fullName'] ?? 'User', '2,450 kcal', 'Active', index == 0);
          },
        );
      },
    );
  }

  Widget _buildLeaderboardTile(int rank, String name, String calories, String time, bool isFirst) {
    final cardColor = Theme.of(context).cardColor;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: Row(
        children: [
          Text('#$rank', style: TextStyle(fontWeight: FontWeight.bold, color: isFirst ? Colors.amber : Colors.grey)),
          const SizedBox(width: 15),
          CircleAvatar(backgroundColor: AppColors.secondary, child: Text(name[0], style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 15),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(calories, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            Text(time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          ])
        ],
      ),
    );
  }

  Widget _buildContactUsPage(BuildContext context) {
    final subjectController = TextEditingController();
    final messageController = TextEditingController();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildPremiumTextField('Subject', 'Query topic', subjectController),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: TextField(
              controller: messageController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Your message here...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              onPressed: () async {
                if (subjectController.text.isEmpty || messageController.text.isEmpty) return;
                await FirebaseFirestore.instance.collection('contact_messages').add({
                  'subject': subjectController.text,
                  'message': messageController.text,
                  'userEmail': FirebaseAuth.instance.currentUser?.email,
                  'createdAt': FieldValue.serverTimestamp(),
                });
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message sent successfully!')));
                Navigator.pop(context);
              },
              child: const Text('Send Message', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenericTextPage(String title) {
    return Center(child: Text('Content for $title coming soon.'));
  }
}
