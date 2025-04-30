import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _quizTypes = [
    {
      'title': 'Multiple Choice',
      'description': 'Test your knowledge with MCQs',
      'icon': Icons.check_circle,
      'route': '/mcq-quiz',
    },
    {
      'title': 'True/False',
      'description': 'Quick true or false questions',
      'icon': Icons.rule,
      'route': '/true-false-quiz',
    },
    {
      'title': 'Fill in the Blanks',
      'description': 'Complete the missing words',
      'icon': Icons.edit,
      'route': '/fill-blanks-quiz',
    },
    {
      'title': 'Match the Following',
      'description': 'Match related items',
      'icon': Icons.compare_arrows,
      'route': '/matching-quiz',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Quiz Type',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _quizTypes.length,
        itemBuilder: (context, index) {
          final quiz = _quizTypes[index];
          return _QuizTypeCard(
            title: quiz['title'] as String,
            description: quiz['description'] as String,
            icon: quiz['icon'] as IconData,
            route: quiz['route'] as String,
          );
        },
      ),
    );
  }
}

class _QuizTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String route;

  const _QuizTypeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 