import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final List<Map<String, dynamic>> _modules = [
    {
      'id': '1',
      'title': 'Module 1',
      'description': 'Basic Concepts',
      'color': const Color(0xFF6C63FF),
      'isEnrolled': false,
    },
    {
      'id': '2',
      'title': 'Module 2',
      'description': 'Advanced Topics',
      'color': const Color(0xFF00BFA6),
      'isEnrolled': false,
    },
    {
      'id': '3',
      'title': 'Module 3',
      'description': 'Expert Level',
      'color': const Color(0xFFF50057),
      'isEnrolled': false,
    },
    // Add more modules as needed
  ];

  void _toggleEnrollment(int index) {
    setState(() {
      _modules[index]['isEnrolled'] = !_modules[index]['isEnrolled'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Courses',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Select modules to add to your learning path',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _modules.length,
              itemBuilder: (context, index) {
                final module = _modules[index];
                return _buildModuleCard(module, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(Map<String, dynamic> module, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => _toggleEnrollment(index),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                module['color'].withOpacity(0.8),
                module['color'],
              ],
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      module['description'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: module['isEnrolled']
                      ? Colors.green
                      : Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  module['isEnrolled'] ? Icons.check : Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 