import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';


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
              child: const Text("PFT Map",
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
            fit: BoxFit.cover, 
          ),
        ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Let's start to discover more about PFT!",
              style: TextStyle(
                fontSize: 70, 
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
                  MaterialPageRoute(builder: (context) => const QuizScreen(questionIndex: 0, score: 0)),
                );
              },
              child: const Text("Start the Hunt", style: TextStyle(fontSize:30)),
            ),
          ],
        ),
      ),
      )
    );
  }
}


//questions
const List<Map<String, dynamic>> quizQuestions = [
  {
    "question": "Can you find the dark purple chair?",
    "image": "assets/q1.png", 
    "targetPosition": {"left": 850.0, "top": 250.0, "width": 200.0, "height": 200.0}
  },
  {
    "question": "Can you find the Baguette in the Penera store?",
    "image": "assets/q2.png",
    "targetPosition": {"left": 90.0, "top": 286.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the MMR sign?",
    "image": "assets/q3.png",
    "targetPosition": {"left": 650.0, "top": 50.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the green can?",
    "image": "assets/q4.png",
    "targetPosition": {"left": 185.0, "top": 320.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the pressure screen?",
    "image": "assets/q5.png",
    "targetPosition": {"left": 280.0, "top": 90.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the crushed car?",
    "image": "assets/q6.png",
    "targetPosition": {"left": 600.0, "top": 250.0, "width": 200.0, "height": 200.0}
  }
];


// Quiz Screen
class QuizScreen extends StatefulWidget {
  final int questionIndex;
  final int score;

  const QuizScreen({super.key, required this.questionIndex, required this.score});

  @override
  QuizScreenState createState() => QuizScreenState();
}
  class QuizScreenState extends State<QuizScreen> {
  int timeLeft = 10;
  Timer? _timer;
  bool foundObject = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isSoundLoaded=false;

  //trace the position
  GlobalKey targetKey= GlobalKey();

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    getTargetPosition();
  });
  }

  void preloadSounds() async {
    await audioPlayer.setSource(AssetSource('sounds/correct.mp3'));
    await audioPlayer.setSource(AssetSource('sounds/wrong.mp3'));
    setState(() {
      isSoundLoaded = true;
    });
  }

  void playSound(String sound) async {
    await audioPlayer.play(AssetSource(sound));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        _goToNextScreen(false);
      }
    });
  }

  //get position
  void getTargetPosition(){
    RenderBox renderBox = targetKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    print('Target position: left: ${position.dx}, top: ${position.dy}');
 
  }

  void _goToNextScreen(bool won) {
    _timer?.cancel();
    int newScore = won ? widget.score + 10 : widget.score;

    if (won) {
      playSound('sounds/correct.mp3'); 
    } else {
      playSound('sounds/wrong.mp3'); 
    }

    if (widget.questionIndex < quizQuestions.length - 1) {
      Navigator.pushReplacement(
        context,        
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            questionIndex: widget.questionIndex + 1,
            score: newScore,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(finalScore: newScore),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final questionData = quizQuestions[widget.questionIndex];
    final target = questionData["targetPosition"];

    return Scaffold(
      appBar: AppBar(title: Text('Find the Object!')),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              questionData["image"],
              fit: BoxFit.cover,
            ),
          ),

          // Question Text
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black54,
              child: Text(
                "${questionData["question"]} (⏳ $timeLeft sec)",
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Hidden Object (Clickable)
          Positioned(
            left: target["left"],
            top: target["top"],
            child: GestureDetector(
              onTap: () {
                if (!foundObject) {
                  setState(() {
                    foundObject = true;
                  });
                  _goToNextScreen(true);
                }
              },
              child: Container(
                width: target["width"],
                height: target["height"],
                color: Colors.transparent,//Colors.transparent, // Invisible tap area
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

// Result Screen
class ResultScreen extends StatelessWidget {
  final int finalScore;

  const ResultScreen({super.key, required this.finalScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Game Over!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your final score: $finalScore",
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                );
              },
              child: const Text("Play Again?", style: TextStyle(fontSize:35),),
            ),
          ],
        ),
      ),
    );
  }
}

