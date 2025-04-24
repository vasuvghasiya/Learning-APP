class Content {
  final String id;
  final String moduleId;
  final String title;
  final String description;
  final String type;
  final String url;
  final String? thumbnailUrl;
  final String? duration;
  final int? pageCount;

  Content({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.description,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.duration,
    this.pageCount,
  });

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      id: map['id'] as String,
      moduleId: map['moduleId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      url: map['url'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String?,
      duration: map['duration'] as String?,
      pageCount: map['pageCount'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moduleId': moduleId,
      'title': title,
      'description': description,
      'type': type,
      'url': url,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      if (duration != null) 'duration': duration,
      if (pageCount != null) 'pageCount': pageCount,
    };
  }
} 