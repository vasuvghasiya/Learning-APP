import 'package:flutter/material.dart';

class MatchingQuizScreen extends StatefulWidget {
  const MatchingQuizScreen({super.key});

  @override
  State<MatchingQuizScreen> createState() => _MatchingQuizScreenState();
}

class _MatchingQuizScreenState extends State<MatchingQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;
  Map<String, String?> selectedMatches = {};

  // Sample questions - replace with actual questions from your database
  final List<Map<String, dynamic>> questions = [
    {
      'leftItems': ['Capital of France', 'Capital of Japan', 'Capital of Italy'],
      'rightItems': ['Tokyo', 'Paris', 'Rome'],
      'correctMatches': {
        'Capital of France': 'Paris',
        'Capital of Japan': 'Tokyo',
        'Capital of Italy': 'Rome',
      },
    },
    {
      'leftItems': ['H2O', 'CO2', 'O2'],
      'rightItems': ['Carbon Dioxide', 'Water','Oxygen'],
      'correctMatches': {
        'H2O': 'Water',
        'CO2': 'Carbon Dioxide',
        'O2': 'Oxygen',
      },
    },
    // Add more questions here
  ];

  void checkAnswer() {
    int correctMatches = 0;
    final correctMatchesMap = questions[currentQuestionIndex]['correctMatches'] as Map<String, String>;

    selectedMatches.forEach((leftItem, rightItem) {
      if (correctMatchesMap[leftItem] == rightItem) {
        correctMatches++;
      }
    });

    if (correctMatches == questions[currentQuestionIndex]['leftItems'].length) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedMatches.clear();
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
      selectedMatches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Quiz'),
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
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'Items',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: questions[currentQuestionIndex]['leftItems'].length,
                                  itemBuilder: (context, index) {
                                    final leftItem = questions[currentQuestionIndex]['leftItems'][index];
                                    return Card(
                                      child: ListTile(
                                        title: Text(leftItem),
                                        subtitle: selectedMatches[leftItem] != null
                                            ? Text(
                                                'Matched with: ${selectedMatches[leftItem]}',
                                                style: const TextStyle(color: Colors.green),
                                              )
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'Match With',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: questions[currentQuestionIndex]['rightItems'].length,
                                  itemBuilder: (context, index) {
                                    final rightItem = questions[currentQuestionIndex]['rightItems'][index];
                                    final isSelected = selectedMatches.containsValue(rightItem);
                                    return Card(
                                      child: ListTile(
                                        title: Text(rightItem),
                                        enabled: !isSelected,
                                        onTap: isSelected
                                            ? null
                                            : () {
                                                setState(() {
                                                  final leftItem = questions[currentQuestionIndex]['leftItems']
                                                      .firstWhere((item) => !selectedMatches.containsKey(item),
                                                          orElse: () => '');
                                                  if (leftItem.isNotEmpty) {
                                                    selectedMatches[leftItem] = rightItem;
                                                  }
                                                });
                                              },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: selectedMatches.length == questions[currentQuestionIndex]['leftItems'].length
                        ? checkAnswer
                        : null,
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