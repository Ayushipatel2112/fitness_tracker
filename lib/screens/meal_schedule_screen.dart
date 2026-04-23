import 'package:flutter/material.dart';

class MealScheduleScreen extends StatelessWidget {
  const MealScheduleScreen({super.key});

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
        title: const Text('Meal Schedule', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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
          children: [
            // Calendar Month/Scroller
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
                SizedBox(width: 15),
                Text('May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                SizedBox(width: 15),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _dayItem('Tue', '11', false),
                  _dayItem('Wed', '12', false),
                  _dayItem('Thu', '13', false),
                  _dayItem('Fri', '14', true),
                  _dayItem('Sat', '15', false),
                  _dayItem('Sun', '16', false),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            _mealSection('Breakfast', '2 meals | 230 calories', [
              _mealItem('Honey Pancake', '07:00am', Icons.cake, Colors.orange),
              _mealItem('Coffee', '07:30am', Icons.coffee, Colors.brown),
            ]),
            
            _mealSection('Lunch', '2 meals | 500 calories', [
              _mealItem('Chicken Steak', '01:00pm', Icons.fastfood, Colors.red),
              _mealItem('Milk', '01:20pm', Icons.local_drink, Colors.blue),
            ]),
            
            _mealSection('Snacks', '2 meals | 140 calories', [
              _mealItem('Orange', '04:30pm', Icons.circle, Colors.orange),
              _mealItem('Apple Pie', '04:40pm', Icons.pie_chart, Colors.purple),
            ]),
            
            _mealSection('Dinner', '2 meals | 120 calories', [
              _mealItem('Salad', '07:10pm', Icons.grass, Colors.green),
              _mealItem('Oatmeal', '08:10pm', Icons.food_bank, Colors.brown.shade300),
            ]),
            
            const SizedBox(height: 20),
            // Today Meal Nutritions
            Row(
              children: const [
                Text('Today Meal Nutritions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 15),
            _nutritionBar('Calories', '320 kCal', 0.6, Colors.blue),
            _nutritionBar('Proteins', '30dg', 0.4, Colors.blue),
            _nutritionBar('Fats', '10g', 0.3, Colors.blue),
            _nutritionBar('Carbo', '140g', 0.8, Colors.blue),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _dayItem(String day, String date, bool isActive) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: isActive ? const LinearGradient(colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)]) : null,
        color: !isActive ? Colors.grey.shade50 : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(day, style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          Text(date, style: TextStyle(color: isActive ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _mealSection(String title, String subtitle, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 15),
        ...items,
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _mealItem(String title, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 5),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _nutritionBar(String title, String value, double percent, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(value, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(height: 8, width: double.infinity, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5))),
              FractionallySizedBox(
                widthFactor: percent,
                child: Container(height: 8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
