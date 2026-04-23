import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Privacy Policy', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '1. Types of Data We Collect',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              'We collect personal data that you provide to us when you register for an account, such as your name, email address, physical characteristics, and fitness goals. We also collect data about your workouts, sleep patterns, and nutrition when you use our tracking features.',
              style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '2. Use of Your Personal Data',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              'Your personal data is used to provide you with personalized fitness recommendations, track your progress, and improve our services. We may also use your data to send you important notifications regarding your account or app updates.',
              style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '3. Disclosure of Your Personal Data',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              'We do not sell your personal data to third parties. We may share your data with trusted service providers who assist us in operating our app and delivering our services to you. These third parties are bound by strict confidentiality obligations.',
              style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              '4. Data Security',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              'We implement appropriate technical and organizational measures to protect your personal data against unauthorized access, loss, or alteration. However, please note that no method of transmission over the Internet is 100% secure.',
              style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                'Last updated: April 2026',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
