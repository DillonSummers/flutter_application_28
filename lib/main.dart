import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSU Scavenger Hunt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Welcome Screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scavenger Hunt')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/lsu1.jpg"),
            fit: BoxFit.cover, // Adjusts the image to fill the screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to the LSU Scavenger Hunt",
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Ensuring visibility over the image
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IntroScreen()),
                );
              },
              child: const Text("Begin",
              style: TextStyle(
                fontSize: 30,
              ),),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Mapscreen()),
                );
              },
              child: const Text("Pft Map",
              style: TextStyle(
                fontSize: 27,
              ),),
            ),
          ],
        ),
      ),
      )
    );
  }
}

//map
class Mapscreen extends StatelessWidget{
  const Mapscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PFT Map')),
      body: ListView(
        children: [
          Image.asset("assets/map1.png", fit: BoxFit.contain),
          Image.asset("assets/map2.png", fit: BoxFit.contain),
          Image.asset("assets/map3.png", fit: BoxFit.contain),
        ],
        ),
    );
}
}

// Intro Screen
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scavenger Hunt of PFT')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pft1.jpg"),
            fit: BoxFit.cover, // Adjusts the image to fill the screen
          ),
        ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Time to see how well you know the PFT!",
              style: TextStyle(
                fontSize: 60, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen(questionIndex: 0)),
                );
              },
              child: const Text("Play", style: TextStyle(fontSize:25)),
            ),
          ],
        ),
      ),
      )
    );
  }
}

// List of questions & answers
const List<Map<String, dynamic>> quizQuestions = [
  {
    "question": "What do the Banners by the big stairs say?",
    "options": ["College of Engineering", "Geaux Tigers", "Welcome to LSU", "Innovation Hub"],
    "correct": "College of Engineering"
  },
  {
    "question": "What is the first option listed on the Panera Bread sandwich menu in the PFT?",
    "options": ["Turkey Club", "BLT", "Roast Beef Sandwich", "Grilled Chicken Sandwich with Avocado"],
    "correct": "Grilled Chicken Sandwich with Avocado"
  },
  {
    "question": "What is the room number for the Roy Marrin Auditorium?",
    "options": [ "1200", "1100", "2100", "3100"],
    "correct": "1100"
  },
  {
    "question": "What does it say on the left door of the Chevron center?",
    "options": ["Welcome Engineers", "Innovation Hub", "Geaux Communicate", "Future Tigers"],
    "correct": "Geaux Communicate"
  },
  {
    "question": "What is inside room 2215?",
    "options": [ "A robotics lab", "A computer lab", "A crash test car", "An engineering workshop"],
    "correct": "A crash test car"
  },
  {
    "question": "How many computers are in room 2241?",
    "options": ["48", "50", "49", "51"],
    "correct": "51"
  },
  {
    "question": "What floor is the suite for the college of engineering and computer science?",
    "options": ["3rd floor", "2nd floor", "1st floor", "4th floor"],
    "correct": "3rd floor"
  },
  {
    "question": "Where is the Dr. William A. Brookshire Student Service Office?",
    "options": ["behind the big stairs", "In front of the big stairs", "on the roof", "next to the entrance"],
    "correct": "In front of the big stairs"
  },
  {
    "question": "Which zone has the Dean’s suite of the PFT?",
    "options": ["Zone 1100", "Zone 1300", "Zone 1200", "Zone 1400"],
    "correct": "Zone 1200"
  },
  {
    "question": "What year does the TAU BETA PI statue say it was made?",
    "options": [ "1956", "1942", "2025", "1936"],
    "correct": "1936"
  }
];

// Quiz Screen
class QuizScreen extends StatelessWidget {
  final int questionIndex;

  const QuizScreen({super.key, required this.questionIndex});

  void _navigateToResult(BuildContext context, bool isCorrect) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: isCorrect,
          questionIndex: questionIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionData = quizQuestions[questionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Question ${questionIndex + 1}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                questionData["question"],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            for (String option in questionData["options"])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToResult(context, option == questionData["correct"]);
                  },
                  child: Text(option),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Result Screen
class ResultScreen extends StatelessWidget {
  final bool isCorrect;
  final int questionIndex;

  const ResultScreen({super.key, required this.isCorrect, required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isCorrect ? "Hurray!" : "Oops, Try Again!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isCorrect ? "🎉 Hurray! You got it right! 🎉" : "❌ Oops, try again! ❌",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isCorrect) {
                  if (questionIndex < quizQuestions.length - 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(questionIndex: questionIndex + 1),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CongratsScreen()),
                    );
                  }
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(isCorrect ? "Next" : "Back"),
            ),
          ],
        ),
      ),
    );
  }
}

// Congratulations Screen
class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("You Did It!")),
      body: const Center(
        child: Text(
          "🎉 Congratulations! You completed the LSU Scavenger Hunt! 🎉",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
