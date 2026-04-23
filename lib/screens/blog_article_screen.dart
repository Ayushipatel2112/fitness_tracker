import 'package:flutter/material.dart';

class BlogArticleScreen extends StatelessWidget {
  const BlogArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: const Color(0xFF92A3FD),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.article,
                    size: 80,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF92A3FD).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Workout',
                      style: TextStyle(
                        color: Color(0xFF92A3FD),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Title
                  const Text(
                    'Complete Guide to Building Muscle',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Meta Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'John Fitness',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'April 10, 2026 • 10 min read',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Article Content
                  _buildSection(
                    'Introduction',
                    'Building muscle is a journey that requires dedication, proper nutrition, and consistent training. In this comprehensive guide, we\'ll explore everything you need to know to maximize your muscle growth potential.',
                  ),
                  _buildSection(
                    'Understanding Muscle Growth',
                    'Muscle hypertrophy occurs when muscle fibers are damaged through resistance training and then repair themselves, becoming larger and stronger. This process requires three key elements: progressive overload, adequate protein intake, and sufficient recovery time.',
                  ),
                  _buildSection(
                    'Training Principles',
                    'To build muscle effectively, focus on compound movements like squats, deadlifts, bench press, and rows. Aim for 3-4 sets of 8-12 repetitions per exercise, progressively increasing weight over time. Train each muscle group 2-3 times per week for optimal results.',
                  ),
                  _buildSection(
                    'Nutrition for Muscle Growth',
                    'Consume 1.6-2.2 grams of protein per kilogram of body weight daily. Maintain a slight caloric surplus of 200-500 calories above maintenance. Include complex carbohydrates for energy and healthy fats for hormone production.',
                  ),
                  _buildSection(
                    'Recovery and Rest',
                    'Muscles grow during rest, not during training. Ensure 7-9 hours of quality sleep each night. Allow 48-72 hours between training the same muscle group. Consider active recovery activities like walking or yoga.',
                  ),
                  _buildSection(
                    'Conclusion',
                    'Building muscle is a marathon, not a sprint. Stay consistent with your training, nutrition, and recovery. Track your progress, adjust as needed, and remember that sustainable results take time. Stay patient and trust the process.',
                  ),
                  const SizedBox(height: 30),

                  // Tags
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _tag('Muscle Building'),
                      _tag('Workout'),
                      _tag('Nutrition'),
                      _tag('Fitness Tips'),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Related Articles
                  const Text(
                    'Related Articles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _relatedArticle('Top 10 Muscle Building Foods'),
                  _relatedArticle('Best Workout Split for Beginners'),
                  _relatedArticle('How to Track Your Progress'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _relatedArticle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
