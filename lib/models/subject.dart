class Subject {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final int grade;
  final List<String> topics;

  Subject({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.grade,
    required this.topics,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imagePath: map['imagePath'] as String,
      grade: map['grade'] as int,
      topics: List<String>.from(map['topics'] as List),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'grade': grade,
      'topics': topics,
    };
  }
} 