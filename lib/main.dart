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
import 'screens/profile_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/module_content_screen.dart';
import 'screens/pdf_viewer_screen.dart';
import 'screens/main_screen.dart';
import 'services/sample_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase initialized successfully');

  // Initialize sample data
  final sampleDataService = SampleDataService();
  await sampleDataService.initializeSampleData();
  print('Sample data initialized successfully');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Learning App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/grade-selection': (context) => const GradeSelectionScreen(),
          '/subjects': (context) => const SubjectListScreen(),
          '/content': (context) => const ContentScreen(),
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
        },
      ),
    );
  }
}
