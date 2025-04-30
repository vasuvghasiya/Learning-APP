import 'package:cloud_firestore/cloud_firestore.dart';
import 'module_content_service.dart';

class SampleDataService {
  final ModuleContentService _contentService = ModuleContentService();

  Future<void> initializeSampleData() async {
    // Sample data for Module 1 (Mathematics)
    final module1Content = [
      ModuleContent(
        id: 'video1',
        title: 'Introduction to Algebra',
        type: 'video',
        url: 'https://www.youtube.com/watch?v=mFZTYcApssM',
        duration: '10:24',
        thumbnailUrl: 'https://img.youtube.com/vi/NybHckSEQBI/maxresdefault.jpg',
      ),
      ModuleContent(
        id: 'pdf1',
        title: 'Mathematics Class 9 NCERT Book',
        type: 'pdf',
        url: 'https://ncert.nic.in/textbook/pdf/iemh1dd.pdf',
      ),
      ModuleContent(
        id: 'pdf2',
        title: 'Mathematics Practice Problems',
        type: 'pdf',
        url: 'https://ncert.nic.in/pdf/publication/exemplarproblem/classX/mathematics/jeep1.pdf',
      ),
      ModuleContent(
        id: 'pdf3',
        title: 'Mathematics Lab Manual',
        type: 'pdf',
        url: 'https://ncert.nic.in/pdf/publication/sciencelaboratorymanuals/classX/mathematics/jelm1.pdf',
      ),
    ];

    // Sample data for Module 2 (Science - Physics)
    final module2Content = [
      ModuleContent(
        id: 'video4',
        title: 'Introduction to Physics',
        type: 'video',
        url: 'https://www.youtube.com/watch?v=ZM8ECpBuQYE',
        duration: '18:22',
        thumbnailUrl: 'https://img.youtube.com/vi/ZM8ECpBuQYE/maxresdefault.jpg',
      ),
      ModuleContent(
        id: 'pdf4',
        title: 'Physics NCERT Book',
        type: 'pdf',
        url: 'https://ncert.nic.in/textbook/pdf/keph1dd.pdf',
      ),
      ModuleContent(
        id: 'pdf5',
        title: 'Physics Lab Manual',
        type: 'pdf',
        url: 'https://ncert.nic.in/pdf/publication/sciencelaboratorymanuals/classXII/physics/lelm2.pdf',
      ),
      ModuleContent(
        id: 'pdf6',
        title: 'Physics Practice Problems',
        type: 'pdf',
        url: 'https://ncert.nic.in/pdf/publication/exemplarproblem/classXII/physics/leep1.pdf',
      ),
    ];

    // Sample data for Module 3 (Chemistry)
    final module3Content = [
      ModuleContent(
        id: 'video5',
        title: 'Understanding Chemical Reactions',
        type: 'video',
        url: 'https://www.youtube.com/watch?v=8m6RtOpqvtU',
        duration: '14:15',
        thumbnailUrl: 'https://img.youtube.com/vi/8m6RtOpqvtU/maxresdefault.jpg',
      ),
      ModuleContent(
        id: 'pdf7',
        title: 'Chemistry NCERT Book',
        type: 'pdf',
        url: 'https://ncert.nic.in/textbook/pdf/kech1dd.pdf',
      ),
      ModuleContent(
        id: 'pdf8',
        title: 'Chemistry Lab Manual',
        type: 'pdf',
        url: 'https://ncert.nic.in/pdf/publication/sciencelaboratorymanuals/classXII/chemistry/lelm1.pdf',
      ),
      ModuleContent(
        id: 'pdf9',
        title: 'Chemistry Practice Problems',
        type: 'pdf',
        url: 'https://ncert.nic.in/pdf/publication/exemplarproblem/classXII/chemistry/leep2.pdf',
      ),
    ];

    // Sample data for Module 4 (Biology)
    final module4Content = [
      ModuleContent(
        id: 'video6',
        title: 'Introduction to Biology',
        type: 'video',
        url: 'https://www.youtube.com/watch?v=QnQe0xW_JY4',
        duration: '16:45',
        thumbnailUrl: 'https://img.youtube.com/vi/QnQe0xW_JY4/maxresdefault.jpg',
      ),
      ModuleContent(
        id: 'pdf10',
        title: 'Biology NCERT Book',
        type: 'pdf',
        url: 'https://ncert.nic.in/textbook/pdf/kebo1dd.pdf',
      ),
      ModuleContent(
        id: 'pdf11',
        title: 'Biology Lab Manual',
        type: 'pdf',
        url: 'https://ncert.nic.in/pdf/publication/sciencelaboratorymanuals/classXII/biology/lelm3.pdf',
      ),
      ModuleContent(
        id: 'pdf12',
        title: 'Biology Practice Problems',
        type: 'pdf',
        url: 'https://ncert.nic.in/pdf/publication/exemplarproblem/classXII/biology/leep3.pdf',
      ),
    ];

    // Sample data for Module 5 (English)
    final module5Content = [
      ModuleContent(
        id: 'video7',
        title: 'English Grammar Basics',
        type: 'video',
        url: 'https://www.youtube.com/watch?v=E9d9xh_ALcw',
        duration: '12:30',
        thumbnailUrl: 'https://img.youtube.com/vi/E9d9xh_ALcw/maxresdefault.jpg',
      ),
      ModuleContent(
        id: 'pdf13',
        title: 'English NCERT Book - First Flight',
        type: 'pdf',
        url: 'https://ncert.nic.in/textbook/pdf/jeff1dd.pdf',
      ),
      ModuleContent(
        id: 'pdf14',
        title: 'English NCERT Book - Footprints',
        type: 'pdf',
        url: 'https://ncert.nic.in/textbook/pdf/jeff2dd.pdf',
      ),
      ModuleContent(
        id: 'pdf15',
        title: 'English Grammar Book',
        type: 'pdf',
        url: 'https://ncert.nic.in/textbook/pdf/jehp1dd.pdf',
      ),
    ];

    // Clear existing data
    await clearSampleData();

    // Add content to all modules using batch operations
    await _contentService.addModuleContentBatch('module-1', module1Content);
    await _contentService.addModuleContentBatch('module-2', module2Content);
    await _contentService.addModuleContentBatch('module-3', module3Content);
    await _contentService.addModuleContentBatch('module-4', module4Content);
    await _contentService.addModuleContentBatch('module-5', module5Content);
  }

  Future<void> clearSampleData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final moduleIds = ['module-1', 'module-2', 'module-3', 'module-4', 'module-5'];

    // Delete content from all modules
    for (var moduleId in moduleIds) {
      final snapshot = await firestore
          .collection('modules')
          .doc(moduleId)
          .collection('content')
          .get();
      
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }
} 