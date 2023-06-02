import 'package:flutter/material.dart';
import 'package:quizzapp/quiz_brain.dart';
import 'package:alert/alert.dart';

//Objeto de QuizzBrain
QuizzBrain quiz = QuizzBrain();
int totalscore = 0;
List<Widget> scoreKeeper = [];

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
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
                quiz.getQuestionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)
              ),
              child: Text(
                'Verdadero',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                bool correctAnswer = quiz.getQuestionAnswer;
                if(quiz.quizzFinished()){
                  Alert(message: 'Your score is ' + totalscore.toString(), shortDuration: false).show();
                }
                if(correctAnswer == true){
                  scoreKeeper.add(Icon(Icons.check, color: Colors.green));
                  totalscore++;
                  print('Correcto');
                }else{
                  scoreKeeper.add(Icon(Icons.close, color: Colors.red));
                  print('Incorrecto');
                }
                setState(() {
                  quiz.nextQuestion();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)
              ),
              child: Text(
                'Falso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                bool correctAnswer = quiz.getQuestionAnswer;
                if(quiz.quizzFinished()){
                  Alert(message: 'Your score is ' + totalscore.toString(), shortDuration: false).show();
                }
                if(correctAnswer == false){
                  scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
                  totalscore++;
                  print('Correcto');
                }else{
                  scoreKeeper.add(Icon(Icons.close, color: Colors.red));
                  print('Incorrecto');
                }
                setState(() {
                  quiz.nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
