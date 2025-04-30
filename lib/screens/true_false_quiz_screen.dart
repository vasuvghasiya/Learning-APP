import 'package:flutter/material.dart';

class TrueFalseQuizScreen extends StatefulWidget {
  const TrueFalseQuizScreen({super.key});

  @override
  State<TrueFalseQuizScreen> createState() => _TrueFalseQuizScreenState();
}

class _TrueFalseQuizScreenState extends State<TrueFalseQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;

  // Sample questions - replace with actual questions from your database
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'The Earth is flat.',
      'correctAnswer': false,
    },
    {
      'question': 'Water boils at 100 degrees Celsius at sea level.',
      'correctAnswer': true,
    },
    // Add more questions here
  ];

  void checkAnswer(bool selectedAnswer) {
    if (selectedAnswer == questions[currentQuestionIndex]['correctAnswer']) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        quizCompleted = true;
      });
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('True/False Quiz'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: quizCompleted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quiz Completed!',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your Score: $score/${questions.length}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: resetQuiz,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}/${questions.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    questions[currentQuestionIndex]['question'],
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => checkAnswer(true),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('True'),
                      ),
                      ElevatedButton(
                        onPressed: () => checkAnswer(false),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('False'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
} 