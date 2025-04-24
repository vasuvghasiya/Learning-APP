# Learning Resource App

A cross-platform educational app that provides learning content (videos, quizzes, notes, etc.) for students from 1st to 12th grade.

## Features

- Grade Selection (1-12)
- Subject-wise Learning Content
- Video Lessons
- PDF Notes
- Interactive Quizzes
- User Authentication
- Progress Tracking
- Offline Support

## Getting Started

### Prerequisites

- Flutter SDK (version 3.7.2 or higher)
- Dart SDK (version 3.0.0 or higher)
- Firebase account (for backend services)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/lrapp.git
cd lrapp
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a new Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download and add the configuration files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart
├── models/
│   └── grade.dart
├── screens/
│   └── grade_selection_screen.dart
├── widgets/
├── services/
└── data/
```

## Dependencies

- Firebase Core
- Firebase Auth
- Cloud Firestore
- Firebase Storage
- Provider (State Management)
- Video Player
- PDF Viewer
- And more...

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
