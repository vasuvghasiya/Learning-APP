import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/module_model.dart';
import '../models/content_model.dart';

class SampleDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeSampleData() async {
    // Check if modules already exist
    final modulesSnapshot = await _firestore.collection('modules').get();
    if (modulesSnapshot.docs.isNotEmpty) {
      return; // Data already exists
    }

    // Add modules
    await _addModules();
    
    // Add content for each module
    await _addContent();
  }

  Future<void> _addModules() async {
    final modules = [
      {
        'id': 'module-1',
        'title': 'Mathematics',
        'description': 'Learn fundamental mathematical concepts',
        'color': '#4285F4',
        'icon': 'calculate',
      },
      {
        'id': 'module-2',
        'title': 'Physics',
        'description': 'Explore the laws of physics',
        'color': '#EA4335',
        'icon': 'science',
      },
      {
        'id': 'module-3',
        'title': 'Chemistry',
        'description': 'Discover chemical reactions and elements',
        'color': '#FBBC05',
        'icon': 'biotech',
      },
      {
        'id': 'module-4',
        'title': 'Biology',
        'description': 'Study living organisms and life processes',
        'color': '#34A853',
        'icon': 'eco',
      },
      {
        'id': 'module-5',
        'title': 'English',
        'description': 'Improve language and communication skills',
        'color': '#9C27B0',
        'icon': 'menu_book',
      },
    ];

    for (var module in modules) {
      await _firestore.collection('modules').doc(module['id']).set(module);
    }
  }

  Future<void> _addContent() async {
    // Add videos
    final videos = [
      {
        'id': 'video-1',
        'moduleId': 'module-1',
        'title': 'Introduction to Algebra',
        'description': 'Learn the basics of algebraic expressions',
        'url': 'https://www.youtube.com/watch?v=NybHckSEQBI',
        'thumbnailUrl': 'https://img.youtube.com/vi/NybHckSEQBI/maxresdefault.jpg',
        'duration': '15:30',
      },
      {
        'id': 'video-2',
        'moduleId': 'module-2',
        'title': 'Newton\'s Laws of Motion',
        'description': 'Understanding the fundamental laws of physics',
        'url': 'https://www.youtube.com/watch?v=kKKM8Yj7StM',
        'thumbnailUrl': 'https://img.youtube.com/vi/kKKM8Yj7StM/maxresdefault.jpg',
        'duration': '20:15',
      },
    ];

    // Add PDFs
    final pdfs = [
      {
        'id': 'pdf-1',
        'moduleId': 'module-1',
        'title': 'Algebra Basics',
        'description': 'Comprehensive guide to algebraic concepts',
        'url': 'https://example.com/algebra-basics.pdf',
        'pageCount': 45,
      },
      {
        'id': 'pdf-2',
        'moduleId': 'module-2',
        'title': 'Physics Fundamentals',
        'description': 'Essential physics concepts and formulas',
        'url': 'https://example.com/physics-fundamentals.pdf',
        'pageCount': 60,
      },
    ];

    // Add content to Firestore
    for (var video in videos) {
      await _firestore.collection('content').doc(video['id'] as String).set({
        ...video,
        'type': 'video',
      });
    }

    for (var pdf in pdfs) {
      await _firestore.collection('content').doc(pdf['id'] as String).set({
        ...pdf,
        'type': 'pdf',
      });
    }
  }
} 