import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'config/firebase_options.dart';
import 'providers/auth_provider.dart';
import 'widgets/auth_wrapper.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/grade_selection_screen.dart';
import 'screens/subject_list_screen.dart';
import 'screens/content_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/module_content_screen.dart';
import 'screens/pdf_viewer_screen.dart';
import 'screens/mcq_quiz_screen.dart';
import 'screens/true_false_quiz_screen.dart';
import 'screens/fill_blanks_quiz_screen.dart';
import 'screens/matching_quiz_screen.dart';
import 'services/sample_data_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');

    // Initialize sample data (remove in production)
    final sampleDataService = SampleDataService();
    await sampleDataService.clearSampleData(); // Clear existing data
    await sampleDataService.initializeSampleData();
    print('Sample data initialized successfully');
  } catch (e) {
    print('Error during initialization: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Learning Resource App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/grade-selection': (context) => const GradeSelectionScreen(),
          '/subjects': (context) => const SubjectListScreen(),
          '/content': (context) => const ContentScreen(),
          '/quizzes': (context) => const QuizScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/home': (context) => const HomeDashboardScreen(),
          '/module-content': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return ModuleContentScreen(
              moduleId: args['moduleId'],
              moduleTitle: args['moduleTitle'],
            );
          },
          '/pdf-viewer': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return PdfViewerScreen(
              url: args['url'],
              title: args['title'],
            );
          },
          '/mcq-quiz': (context) => const MCQQuizScreen(),
          '/true-false-quiz': (context) => const TrueFalseQuizScreen(),
          '/fill-blanks-quiz': (context) => const FillBlanksQuizScreen(),
          '/matching-quiz': (context) => const MatchingQuizScreen(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/mcq-quiz'),
              child: const Text('Multiple Choice Quiz'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/true-false-quiz'),
              child: const Text('True/False Quiz'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/fill-blanks-quiz'),
              child: const Text('Fill in the Blanks Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
