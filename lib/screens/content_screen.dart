import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final List<Map<String, String>> _contentTypes = [
    {
      'title': 'Video Lessons',
      'description': 'Watch interactive video lessons',
      'icon': 'video_library',
      'route': '/videos',
    },
    {
      'title': 'PDF Notes',
      'description': 'Read and download PDF notes',
      'icon': 'picture_as_pdf',
      'route': '/pdfs',
    },
    {
      'title': 'Practice Quizzes',
      'description': 'Test your knowledge',
      'icon': 'quiz',
      'route': '/quizzes',
    },
    {
      'title': 'Interactive Games',
      'description': 'Learn through fun games',
      'icon': 'sports_esports',
      'route': '/games',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Content Type',
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
        itemCount: _contentTypes.length,
        itemBuilder: (context, index) {
          final content = _contentTypes[index];
          return _ContentTypeCard(
            title: content['title']!,
            description: content['description']!,
            icon: content['icon']!,
            route: content['route']!,
          );
        },
      ),
    );
  }
}

class _ContentTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final String route;

  const _ContentTypeCard({
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
                _getIcon(icon),
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

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'video_library':
        return Icons.video_library;
      case 'picture_as_pdf':
        return Icons.picture_as_pdf;
      case 'quiz':
        return Icons.quiz;
      case 'sports_esports':
        return Icons.sports_esports;
      default:
        return Icons.error;
    }
  }
} 