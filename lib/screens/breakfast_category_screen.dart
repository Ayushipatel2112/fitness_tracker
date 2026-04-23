import 'package:flutter/material.dart';

class BreakfastCategoryScreen extends StatelessWidget {
  const BreakfastCategoryScreen({super.key});

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
        title: const Text('Breakfast', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
            child: IconButton(icon: const Icon(Icons.more_horiz, color: Colors.black), onPressed: () {}),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search Pancake',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.tune, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Category Slider
            const Text('Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _categoryItem('Salad', Colors.blue.withOpacity(0.1), Icons.food_bank),
                  _categoryItem('Cake', Colors.purple.withOpacity(0.1), Icons.cake),
                  _categoryItem('Pie', Colors.blue.withOpacity(0.1), Icons.pie_chart),
                  _categoryItem('Smoothies', Colors.orange.withOpacity(0.1), Icons.local_drink),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Recommendation for Diet
            const Text('Recommendation\nfor Diet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                   _recommendationCard('Honey Pancake', 'Easy | 30mins | 180kCal', const Color(0xFF92A3FD).withOpacity(0.1), Colors.orange),
                   _recommendationCard('Canai Bread', 'Easy | 20mins | 230kCal', Colors.purple.withOpacity(0.1), Colors.brown),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Popular
            const Text('Popular', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _popularItem('Blueberry Pancake', 'Medium | 30mins | 230kCal', Icons.cake, Colors.purple),
            _popularItem('Salmon Nigiri', 'Medium | 20mins | 120kCal', Icons.set_meal, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(String title, Color bgColor, IconData icon) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.orange, size: 24),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _recommendationCard(String title, String subtitle, Color bgColor, Color iconColor) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(Icons.breakfast_dining, size: 80, color: iconColor),
          const SizedBox(height: 15),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF92A3FD),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            ),
            child: const Text('View', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _popularItem(String title, String subtitle, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.purple.shade100)),
            child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.purple.shade200),
          ),
        ],
      ),
    );
  }
}
