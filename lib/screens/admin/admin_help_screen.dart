import 'package:flutter/material.dart';

class AdminHelpScreen extends StatelessWidget {
  const AdminHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1D1617);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF7F8F8),
      appBar: AppBar(
        title: Text('Help Center', 
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Support Resources'),
            _buildHelpCard(
              'Documentation', 
              'Detailed guide on how to manage the platform, users, and data.', 
              Icons.description_outlined,
              const Color(0xFF92A3FD),
            ),
            _buildHelpCard(
              'Technical Support', 
              'Contact the development team for bug reports or feature requests.', 
              Icons.support_agent_outlined,
              const Color(0xFFC58BF2),
            ),
            _buildHelpCard(
              'FAQs', 
              'Find answers to commonly asked questions about the admin panel.', 
              Icons.help_center_outlined,
              const Color(0xFFEEA4CE),
            ),
            
            const SizedBox(height: 30),
            _buildSectionHeader('Common Topics'),
            _buildTopicItem('How to add a new workout?', context),
            _buildTopicItem('Managing user permissions', context),
            _buildTopicItem('Viewing platform analytics', context),
            _buildTopicItem('Responding to contact messages', context),

            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.white, size: 30),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      'Pro Tip: Use the search bar on the home screen to quickly find users or messages.',
                      style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 15),
      child: Text(title, 
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF92A3FD))),
    );
  }

  Widget _buildHelpCard(String title, String desc, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1D1617))),
                const SizedBox(height: 5),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicItem(String text, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87)),
            const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
