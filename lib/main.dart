import 'package:flutter/material.dart';
import 'questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment 2',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}



class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<int> _userAnswers = List.filled(questionList.length, -1);
  bool showResult = false;

  void _selectIndex(index) {
    setState(() {
      _userAnswers[_currentIndex] = index;
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (_currentIndex < questionList.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      setState(() {
        showResult = true;
      });
    }
  }

  int _calculateScore() {
    int numCorrect = 0;
    for (int i = 0; i < questionList.length; i++) {
      if (_userAnswers[i] == questionList[i]['answerIndex']) {
        numCorrect++;
      }
    }
    return numCorrect;
  }

  List getFeedback(sc) {
    double resultScore = sc * (100 / questionList.length);
    if (resultScore >= 80) {
      return ["Total Score: $resultScore", "Perfect!"];
    } else if (resultScore >= 60) {
      return ["Total Score: $resultScore", "Great Job!"];
    } else {
      return ["Total Score: $resultScore", "Bad Result, Improve Yourself!"];
    }
  }

  @override
  Widget build(BuildContext context) {
    int score = _calculateScore();
    List result = getFeedback(score);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Quiz App',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xffFD5620),
        ),
        body: renderBody(result));
  }

  renderBody(res) {
    if (!showResult) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Text(
              questionList[_currentIndex]['question'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
                children: List.generate(
                    questionList[_currentIndex]['options'].length,
                    (index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _selectIndex(index),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 40.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor: const Color(0xffFD5620),
                              ),
                              child: Text(
                                questionList[_currentIndex]['options'][index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ))),
            const SizedBox(height: 16.0),
          ],
        ),
      );
    } else if (showResult) {
      return Center(
        child: Column(
          children: [
            const Text(
              "Done!",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Text(
              res[0],
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              res[1],
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                setState(() {
                  showResult = false;
                  _currentIndex = 0;
                  // _userAnswers = List.filled(questionList.length, -1);
                });
              },
              child: const Text(
                'Restart The App',
                style: TextStyle(color: Color(0xffFD5620)),
              ),
            ),
          ],
        ),
      );
    }
  }
}
