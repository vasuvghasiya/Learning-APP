import 'package:cloud_firestore/cloud_firestore.dart';

class ModuleContent {
  final String id;
  final String title;
  final String type; // 'video' or 'pdf'
  final String url;
  final String? thumbnailUrl;
  final String? duration;
  final DateTime? createdAt;

  ModuleContent({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.duration,
    this.createdAt,
  });

  factory ModuleContent.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ModuleContent(
      id: doc.id,
      title: data['title'] ?? '',
      type: data['type'] ?? '',
      url: data['url'] ?? '',
      thumbnailUrl: data['thumbnailUrl'],
      duration: data['duration'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}

class ModuleContentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all content for a specific module
  Future<List<ModuleContent>> getModuleContent(String moduleId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('modules')
          .doc(moduleId)
          .collection('content')
          .orderBy('createdAt', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => ModuleContent.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Error fetching module content: $e');
    }
  }

  // Add multiple content items to a module
  Future<void> addModuleContentBatch(String moduleId, List<ModuleContent> contentList) async {
    try {
      final batch = _firestore.batch();
      final contentCollection = _firestore
          .collection('modules')
          .doc(moduleId)
          .collection('content');

      for (var content in contentList) {
        final docRef = contentCollection.doc(content.id);
        batch.set(docRef, content.toMap());
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Error adding module content: $e');
    }
  }

  // Add a single content item to a module
  Future<void> addModuleContent(String moduleId, ModuleContent content) async {
    try {
      await _firestore
          .collection('modules')
          .doc(moduleId)
          .collection('content')
          .doc(content.id)
          .set(content.toMap());
    } catch (e) {
      throw Exception('Error adding module content: $e');
    }
  }

  // Update existing content
  Future<void> updateModuleContent(
      String moduleId, String contentId, ModuleContent content) async {
    try {
      await _firestore
          .collection('modules')
          .doc(moduleId)
          .collection('content')
          .doc(contentId)
          .update(content.toMap());
    } catch (e) {
      throw Exception('Error updating module content: $e');
    }
  }

  // Delete content
  Future<void> deleteModuleContent(String moduleId, String contentId) async {
    try {
      await _firestore
          .collection('modules')
          .doc(moduleId)
          .collection('content')
          .doc(contentId)
          .delete();
    } catch (e) {
      throw Exception('Error deleting module content: $e');
    }
  }

  // Get content by type (video or pdf)
  Future<List<ModuleContent>> getModuleContentByType(
      String moduleId, String type) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('modules')
          .doc(moduleId)
          .collection('content')
          .where('type', isEqualTo: type)
          .orderBy('createdAt', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => ModuleContent.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Error fetching module content by type: $e');
    }
  }
} 