import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Authentication Methods
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update the user's display name
      await userCredential.user?.updateDisplayName(displayName);
      
      return userCredential;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'operation-not-allowed':
          return 'Email/password accounts are not enabled.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        default:
          return 'An error occurred: ${error.message}';
      }
    }
    return 'An unexpected error occurred.';
  }

  // Firestore Methods
  Future<List<Map<String, dynamic>>> getSubjectsForGrade(int grade) async {
    try {
      final snapshot = await _firestore
          .collection('subjects')
          .where('grade', isEqualTo: grade)
          .get();
      
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to get subjects: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTopicsForSubject(String subjectId) async {
    try {
      final snapshot = await _firestore
          .collection('topics')
          .where('subjectId', isEqualTo: subjectId)
          .get();
      
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to get topics: $e');
    }
  }

  // Storage Methods
  Future<String> getVideoUrl(String videoPath) async {
    try {
      return await _storage.ref(videoPath).getDownloadURL();
    } catch (e) {
      throw Exception('Failed to get video URL: $e');
    }
  }

  Future<String> getPdfUrl(String pdfPath) async {
    try {
      return await _storage.ref(pdfPath).getDownloadURL();
    } catch (e) {
      throw Exception('Failed to get PDF URL: $e');
    }
  }

  // User Progress Methods
  Future<void> updateUserProgress(String userId, String topicId, Map<String, dynamic> progress) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(topicId)
          .set(progress);
    } catch (e) {
      throw Exception('Failed to update progress: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserProgress(String userId, String topicId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(topicId)
          .get();
      
      return doc.data();
    } catch (e) {
      throw Exception('Failed to get progress: $e');
    }
  }
} 