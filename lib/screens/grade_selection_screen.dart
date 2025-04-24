import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class GradeSelectionScreen extends StatefulWidget {
  const GradeSelectionScreen({super.key});

  @override
  State<GradeSelectionScreen> createState() => _GradeSelectionScreenState();
}

class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _grades = [
    {
      'grade': '1',
      'title': 'Grade 1',
      'description': 'Educational content for 1st grade students',
      'color': const Color(0xFF6C63FF),
      'students': 16,
      'sets': 18,
    },
    {
      'grade': '2',
      'title': 'Grade 2',
      'description': 'Educational content for 2nd grade students',
      'color': const Color(0xFF00BFA6),
      'students': 29,
      'sets': 28,
    },
    {
      'grade': '3',
      'title': 'Grade 3',
      'description': 'Educational content for 3rd grade students',
      'color': const Color(0xFFF50057),
      'students': 32,
      'sets': 9,
    },
    {
      'grade': '4',
      'title': 'Grade 4',
      'description': 'Educational content for 4th grade students',
      'color': const Color(0xFFFF9800),
      'students': 25,
      'sets': 15,
    },
    {
      'grade': '5',
      'title': 'Grade 5',
      'description': 'Educational content for 5th grade students',
      'color': const Color(0xFF2196F3),
      'students': 35,
      'sets': 22,
    },
    {
      'grade': '6',
      'title': 'Grade 6',
      'description': 'Educational content for 6th grade students',
      'color': const Color(0xFF4CAF50),
      'students': 28,
      'sets': 20,
    },
  ];

  List<Map<String, dynamic>> _filteredGrades = [];

  @override
  void initState() {
    super.initState();
    _filteredGrades = _grades;
    _searchController.addListener(_filterGrades);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterGrades() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredGrades = _grades.where((grade) {
        return grade['title'].toLowerCase().contains(query) ||
            grade['description'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Materials',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.tune),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildTab(true, 'Your classes'),
                      const SizedBox(width: 20),
                      _buildTab(false, 'Learning sets'),
                      const SizedBox(width: 20),
                      _buildTab(false, 'Join classes'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _filteredGrades.length,
                itemBuilder: (context, index) {
                  final grade = _filteredGrades[index];
                  return _buildGradeCard(context, grade);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new class/grade
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTab(bool isSelected, String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        color: isSelected ? Colors.black : Colors.grey[600],
        decoration: isSelected ? TextDecoration.underline : null,
        decorationThickness: 2,
      ),
    );
  }

  Widget _buildGradeCard(BuildContext context, Map<String, dynamic> grade) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
          authProvider.setSelectedGrade(grade['grade']);
          Navigator.pushReplacementNamed(context, '/home');
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                grade['color'].withOpacity(0.8),
                grade['color'],
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'B2',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                grade['title'],
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildStat('${grade['sets']}', 'Learning sets'),
                  const SizedBox(width: 12),
                  _buildStat('${grade['students']}', 'Students'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
} 