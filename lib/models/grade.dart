class Grade {
  final int id;
  final String name;
  final String description;
  final String imagePath;

  Grade({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
  });

  static List<Grade> getGrades() {
    return List.generate(12, (index) {
      final gradeNumber = index + 1;
      return Grade(
        id: gradeNumber,
        name: 'Grade $gradeNumber',
        description: 'Educational content for $gradeNumber${_getOrdinalSuffix(gradeNumber)} grade students',
        imagePath: 'assets/images/grade_$gradeNumber.png',
      );
    });
  }

  static String _getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
} 