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
        quizBrain.addMaybe();
        scoreKeeper.add(Icon(
          Icons.circle,
          color: Colors.grey,
        ));
      }
      if (quizBrain.isFinished() == false) {
        quizBrain.nextQuestion();
      } else {
        quizBrain.showQuizResults(context);
        quizBrain.reset();
        scoreKeeper = [];
      }
    });
  }

  Widget buildText(String text) {
    return Expanded(
        flex: 5,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }

  Widget buildButton(String buttonText, Color buttonColor, String answerInput) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: FlatButton(
          textColor: Colors.white,
          color: buttonColor,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            checkAnswer(answerInput);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildText(quizBrain.getQuestionText()),
        buildText(
            'Correct Rate: ' + quizBrain.getCorrectRate().toString() + '%'),
        buildText(
            'Total Progress: ' + quizBrain.getProgressRate().toString() + '%'),
        buildButton('True', Colors.green, 'true'),
        buildButton('False', Colors.red, 'false'),
        buildButton('Maybe', Colors.grey, 'maybe'),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
