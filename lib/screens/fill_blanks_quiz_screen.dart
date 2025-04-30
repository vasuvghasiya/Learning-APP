import 'package:flutter/material.dart';

class FillBlanksQuizScreen extends StatefulWidget {
  const FillBlanksQuizScreen({super.key});

  @override
  State<FillBlanksQuizScreen> createState() => _FillBlanksQuizScreenState();
}

class _FillBlanksQuizScreenState extends State<FillBlanksQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;
  final TextEditingController _answerController = TextEditingController();

  // Sample questions - replace with actual questions from your database
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'The capital of France is _____',
      'correctAnswer': 'paris',
    },
    {
      'question': 'The chemical symbol for water is H2_____',
      'correctAnswer': 'o',
    },
    // Add more questions here
  ];

  void checkAnswer() {
    final userAnswer = _answerController.text.toLowerCase().trim();
    if (userAnswer == questions[currentQuestionIndex]['correctAnswer']) {
      score++;
    }

    _answerController.clear();

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
      _answerController.clear();
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill in the Blanks'),
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
                  TextField(
                    controller: _answerController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your answer',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => checkAnswer(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: checkAnswer,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
    );
  }
} 