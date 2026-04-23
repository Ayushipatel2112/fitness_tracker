import 'package:flutter/material.dart';

class GenericProfileSubScreen extends StatelessWidget {
  final String title;

  const GenericProfileSubScreen({super.key, required this.title});

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
        title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 100, color: Colors.grey.shade300),
            const SizedBox(height: 20),
            Text('$title Screen', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 10),
            const Text('Static UI Prototype Page', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
