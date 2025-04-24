import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';
import '../screens/grade_selection_screen.dart';
import '../screens/home_dashboard_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If not authenticated, show login screen
        if (!authProvider.isAuthenticated) {
          return const LoginScreen();
        }

        // If authenticated but no grade selected, show grade selection
        if (authProvider.selectedGrade == null) {
          return const GradeSelectionScreen();
        }

        // If authenticated and grade selected, show home dashboard
        return const HomeDashboardScreen();
      },
    );
  }
} 