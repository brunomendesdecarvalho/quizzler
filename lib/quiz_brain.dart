import 'package:flutter/material.dart';

import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _progress = 0;
  int _correctAnswers = 0;
  int _maybeAnswers = 0;
  double _correctRate = 0.0;
  double _progressRate = 0.0;

  List<Question> _questionBank = [
    Question(
        'Vivi Ornitier é o personagem jogável mais velho de Final Fantasy IX',
        false),
    Question('Sora usa um garfo como arma em Kingdom Hearts', false),
    Question(
        'Chris Redfield é o personagem que mais aparece nos jogos da saga Resident Evil',
        true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  double getCorrectRate() {
    return _correctRate;
  }

  void calcCorrectRate(bool isCorrect) {
    if (isCorrect) {
      _correctAnswers += 1;
    }
    _correctRate = 100 * (_correctAnswers / _progress);
  }

  void calcProgress() {
    _progress += 1;
    _progressRate = _progress / _questionBank.length;
  }

  void addMaybe() {
    this._maybeAnswers += 1;
  }

  double getProgressRate() {
    return _progressRate;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _progress = 0;
    _correctAnswers = 0;
    _maybeAnswers = 0;
    _progressRate = 0.0;
    _correctRate = 0.0;
    _questionNumber = 0;
  }

  showQuizResults(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alerta = AlertDialog(
      title: Text("RESULTS"),
      content: Text("Correct answers: " +
          this._correctAnswers.toString() +
          "\n'Maybe' answers: " +
          this._maybeAnswers.toString() +
          "\nTotal score: " +
          this._correctRate.toStringAsFixed(2) +
          "%"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
