import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  User? _user;
  bool _isLoading = true;
  String? _selectedGrade;

  AuthProvider() {
    _init();
  }

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  String? get selectedGrade => _selectedGrade;

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();

    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _firebaseService.signInWithEmailAndPassword(email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password, String displayName) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _firebaseService.signUpWithEmailAndPassword(email, password, displayName);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();
      await _firebaseService.signOut();
      _selectedGrade = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedGrade(String grade) {
    _selectedGrade = grade;
    notifyListeners();
  }
} 