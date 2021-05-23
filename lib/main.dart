import 'package:flutter/material.dart';
import 'quiz_brain.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      home: QuizPage(title: 'Quizzler Questions'),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuizPageState createState() => _QuizPageState();
}

QuizBrain quizBrain = QuizBrain();

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(String userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    bool userAnswer = true;
    if (userPickedAnswer != 'true') {
      userAnswer = !userAnswer;
    }
    setState(() {
      if (quizBrain.isFinished() == false) {
        quizBrain.calcProgress();
        if (userAnswer == correctAnswer && userPickedAnswer != 'maybe') {
          quizBrain.calcCorrectRate(true);
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else if (userAnswer != correctAnswer && userPickedAnswer != 'maybe') {
          quizBrain.calcCorrectRate(false);
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        } else {
          quizBrain.calcCorrectRate(false);
          scoreKeeper.add(Icon(
            Icons.circle,
            color: Colors.grey,
          ));
        }
        quizBrain.nextQuestion();
      } else {
        quizBrain.reset();
        scoreKeeper = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
        Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Center(
                child: Text(
                  'Correct Rate: ' +
                      quizBrain.getCorrectRate().toString() +
                      '%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
        Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Center(
                child: Text(
                  'Total Progress: ' +
                      quizBrain.getProgressRate().toString() +
                      '%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer("true");
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer("false");
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.grey,
              child: Text(
                'Maybe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer("maybe");
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
