import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  final List<String> inputs = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#22252D'),
      appBar: AppBar(
        elevation: 15.0,
        backgroundColor: HexColor('#2A2D37'),
        title: Center(
          child: Text(
            'Calculator',
            style: TextStyle(color: Colors.teal, fontSize: 35.0),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                userInput,
                style: TextStyle(fontSize: 40.0, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.centerRight,
              child: Text(
                answer,
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 50.0, right: 15.0, left: 15.0, bottom: 10.0),
            child: Container(
              width: 450,
              height: 480,
              decoration: BoxDecoration(
                  color: HexColor('#2A2D37'),
                  borderRadius: BorderRadius.circular(30.0)),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                  itemCount: inputs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Button(
                        buttonTapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: inputs[index],
                        color: Colors.teal.shade400,
                        textColor: Colors.black,
                      );
                    } else if (index == 1) {
                      return Button(
                        buttonText: inputs[index],
                        color: Colors.teal.shade400,
                        textColor: Colors.black,
                      );
                    } else if (index == 2) {
                      return Button(
                        buttonTapped: () {
                          setState(() {
                            userInput += inputs[index];
                          });
                        },
                        buttonText: inputs[index],
                        color: Colors.teal.shade400,
                        textColor: Colors.black,
                      );
                    } else if (index == 3) {
                      return Button(
                        buttonTapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: inputs[index],
                        color: Colors.teal.shade400,
                        textColor: Colors.black,
                      );
                    } else if (index == 18) {
                      return Button(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: inputs[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    } else {
                      return Button(
                        buttonTapped: () {
                          setState(() {
                            userInput += inputs[index];
                          });
                        },
                        buttonText: inputs[index],
                        color: isOperator(inputs[index])
                            ? Colors.pink
                            : Colors.white,
                        textColor: isOperator(inputs[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
