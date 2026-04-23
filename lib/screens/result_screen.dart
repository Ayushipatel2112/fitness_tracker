import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isPhotoTab = true;

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
        title: const Text('Result', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
            child: IconButton(icon: const Icon(Icons.share, color: Colors.black), onPressed: () {}),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
            child: IconButton(icon: const Icon(Icons.more_horiz, color: Colors.black), onPressed: () {}),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Toggle Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isPhotoTab = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _isPhotoTab ? const Color(0xFF92A3FD) : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Photo',
                          style: TextStyle(
                            color: _isPhotoTab ? Colors.white : Colors.grey,
                            fontWeight: _isPhotoTab ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isPhotoTab = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !_isPhotoTab ? const Color(0xFF92A3FD) : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Statistic',
                          style: TextStyle(
                            color: !_isPhotoTab ? Colors.white : Colors.grey,
                            fontWeight: !_isPhotoTab ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          Expanded(
            child: _isPhotoTab ? _buildPhotoTab() : _buildStatisticTab(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF92A3FD),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              elevation: 0,
            ),
            child: const Text('Back to Home', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Average Progress', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Good', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(height: 15, width: double.infinity, decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10))),
              Container(height: 15, width: 250, decoration: BoxDecoration(color: const Color(0xFF92A3FD), borderRadius: BorderRadius.circular(10))),
              const Positioned(
                left: 110,
                child: Text('62%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('May', style: TextStyle(color: Colors.grey, fontSize: 14)),
              Text('June', style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 15),
          
          _photoCompareRow('Front Facing'),
          _photoCompareRow('Back Facing'),
          _photoCompareRow('Left Facing'),
          _photoCompareRow('Right Facing'),
        ],
      ),
    );
  }

  Widget _photoCompareRow(String title) {
    return Column(
      children: [
        Center(child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12))),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.person, color: Colors.grey, size: 50),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.person, color: Colors.grey, size: 50),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStatisticTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(20)),
            child: const Center(child: Text('Graph Comparison\n(May vs June)', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey))),
          ),
          const SizedBox(height: 30),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('May', style: TextStyle(color: Colors.grey, fontSize: 14)),
              Text('June', style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 20),
          
          _statProgressRow('Lose Weight', '33%', '67%'),
          _statProgressRow('Height Increase', '88%', '12%', color: Colors.pink.shade300),
          _statProgressRow('Muscle Mass Increase', '57%', '43%'),
          _statProgressRow('Abs', '89%', '11%', color: Colors.pink.shade300),
        ],
      ),
    );
  }

  Widget _statProgressRow(String title, String leftVal, String rightVal, {Color? color}) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(leftVal, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(width: 10),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Container(height: 8, color: color ?? const Color(0xFF92A3FD))),
                    Expanded(flex: 7, child: Container(height: 8, color: Colors.grey.shade200)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(rightVal, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
