import 'package:flutter/material.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  const WorkoutDetailsScreen({super.key});

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
            icon: const Icon(Icons.close, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
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
            // Video Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF92A3FD).withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(Icons.play_circle_fill, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title
            const Text('Jumping Jack', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 5),
            Text('Easy | 390 Calories Burn', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            const SizedBox(height: 25),
            
            // Descriptions
            const Text('Descriptions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                children: [
                  const TextSpan(text: 'A jumping jack, also known as a star jump and called a side-straddle hop in the US military, is a physical jumping exercise performed by jumping to a position with the legs spread wide '),
                  TextSpan(text: 'Read More...', style: TextStyle(color: const Color(0xFF92A3FD), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            
            // How To Do It
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('How To Do It', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('4 Steps', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 15),
            
            _stepItem('01', 'Spread Your Arms', 'To make the gestures feel more relaxed, stretch your arms as you start this movement. No bending of hands.', isLast: false),
            _stepItem('02', 'Rest at The Toe', 'The basis of this movement is jumping. Now, what needs to be considered is that you have to use the tips of your feet', isLast: false),
            _stepItem('03', 'Adjust Foot Movement', 'Jumping Jack is not just an ordinary jump. But, you also have to pay close attention to leg movements.', isLast: false),
            _stepItem('04', 'Clapping Both Hands', 'This cannot be taken lightly. You see, without realizing it, the clapping of your hands helps you to keep your rhythm while doing the Jumping Jack', isLast: true),
            
            const SizedBox(height: 25),
            const Text('Custom Repetitions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_fire_department, color: Colors.orange.withOpacity(0.5)),
                const SizedBox(width: 10),
                const Text('450 Calories Burn', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(width: 15),
                const Text('30', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black)),
                const SizedBox(width: 15),
                const Text('times', style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
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
                child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _stepItem(String stepNumber, String title, String description, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(stepNumber, style: TextStyle(color: Colors.purple.shade300, fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Container(width: 15, height: 15, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.purple.shade300, width: 2))),
            if (!isLast)
              Container(
                width: 1,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.purple.shade100,
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
