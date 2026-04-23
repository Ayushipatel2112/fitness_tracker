import 'package:flutter/material.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Header Background and Image
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF9DCEFF),
            ),
            child: const Center(
              child: Icon(Icons.cake, size: 100, color: Colors.white),
            ),
          ),
          // Content
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Blueberry Pancake', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                          const SizedBox(height: 2),
                          Row(
                            children: const [
                              Text('by ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              Text('James Ruth', style: TextStyle(color: Color(0xFF92A3FD), fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle),
                        child: const Icon(Icons.favorite, color: Colors.red, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  
                  // Nutrition
                  const Text('Nutrition', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _nutritionTile('180kCal', Icons.local_fire_department, Colors.orange),
                        const SizedBox(width: 15),
                        _nutritionTile('30g fats', Icons.lunch_dining, Colors.orange),
                        const SizedBox(width: 15),
                        _nutritionTile('20g proteins', Icons.fitness_center, Colors.blue),
                        const SizedBox(width: 15),
                        _nutritionTile('50g carbs', Icons.eco, Colors.green),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Descriptions
                  const Text('Descriptions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                      children: [
                        const TextSpan(text: 'Pancakes are some people\'s favorite breakfast, who doesn\'t like pancakes? Especially with the real honey splash on top of the pancakes, of course everyone loves that! besides being '),
                        TextSpan(text: 'Read More...', style: TextStyle(color: const Color(0xFF92A3FD), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Ingredients
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ingredients That You\nWill Need', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('6 items', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ingredientItem('Wheat Flour', '100gr', Icons.waves),
                        _ingredientItem('Sugar', '3 tbsp', Icons.scatter_plot),
                        _ingredientItem('Baking Soda', '2 tsp', Icons.medication),
                        _ingredientItem('Eggs', '2 items', Icons.egg),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Step by Step
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Step by Step', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('8 Steps', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  _stepItem('01', 'Step 1', 'Prepare all of the ingredients that needed', true),
                  _stepItem('02', 'Step 2', 'Mix flour, sugar, salt, and baking powder', false),
                  _stepItem('03', 'Step 3', 'In a separate place, mix the eggs and liquid milk until blended', false),
                  _stepItem('04', 'Step 4', 'Prepare all of the ingredients that needed', false, isLast: true),
                  
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF92A3FD),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        elevation: 0,
                      ),
                      child: const Text('Add to Breakfast Meal', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // App Bar Buttons
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                  child: IconButton(icon: const Icon(Icons.more_horiz, color: Colors.black), onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nutritionTile(String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF92A3FD).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 5),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _ingredientItem(String name, String amount, IconData icon) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: Colors.grey.shade400, size: 30),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
          const SizedBox(height: 2),
          Text(amount, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _stepItem(String stepNumber, String title, String description, bool isActive, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(stepNumber, style: TextStyle(color: isActive ? Colors.purple.shade300 : Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isActive ? Colors.purple.shade300 : Colors.grey.shade300, width: 2),
              ),
              child: isActive ? Center(child: Container(width: 7, height: 7, decoration: BoxDecoration(color: Colors.purple.shade300, shape: BoxShape.circle))) : null,
            ),
            if (!isLast)
              Container(
                width: 1,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 5),
              Text(description, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.5)),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
}
