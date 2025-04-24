class Module {
  final String id;
  final String title;
  final String description;
  final String color;
  final String icon;

  Module({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      color: map['color'] as String,
      icon: map['icon'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'icon': icon,
    };
  }
} 