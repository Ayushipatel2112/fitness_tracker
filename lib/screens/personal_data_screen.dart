import 'package:flutter/material.dart';

class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

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
        title: const Text('Personal Data', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildDataCard('Age', '22 Years', Icons.cake),
            const SizedBox(height: 15),
            _buildDataCard('Height', '180 cm', Icons.height),
            const SizedBox(height: 15),
            _buildDataCard('Weight', '65 kg', Icons.monitor_weight),
            const SizedBox(height: 15),
            _buildDataCard('Gender', 'Male', Icons.person),
            const SizedBox(height: 15),
            _buildDataCard('Goal', 'Lose Weight', Icons.track_changes),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF92A3FD)),
              const SizedBox(width: 15),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          Text(value, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }
}
