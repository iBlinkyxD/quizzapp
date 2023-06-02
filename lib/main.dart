import 'package:flutter/material.dart';
import 'package:quizzapp/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//Objeto de QuizzBrain
QuizzBrain quiz = QuizzBrain();
List<Widget> scoreKeeper = [];
int totalscore = 0;
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
                if(correctAnswer == true){
                  scoreKeeper.add(Icon(Icons.check, color: Colors.green));
                  totalscore ++;
                  print('Correcto');
                }else{
                  scoreKeeper.add(Icon(Icons.close, color: Colors.red));
                  print('Incorrecto');
                }
                if(quiz.quizzFinished()){
                  Alert(context: context,
                      title: 'Score',
                      desc: totalscore.toString()
                  ).show();
                  quiz.quizReset();
                  totalscore = 0;
                  scoreKeeper.clear();
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
                if(correctAnswer == false){
                  scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
                  totalscore ++;
                  print('Correcto');
                }else{
                  scoreKeeper.add(Icon(Icons.close, color: Colors.red));
                  print('Incorrecto');
                }
                if(quiz.quizzFinished()){
                  Alert(context: context,
                      title: 'Score',
                      desc: totalscore.toString()
                  ).show();
                  quiz.quizReset();
                  totalscore = 0;
                  scoreKeeper.clear();
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
