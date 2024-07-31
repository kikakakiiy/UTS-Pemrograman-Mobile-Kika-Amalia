import 'package:flutter/material.dart';
import 'dart:math'; // Import untuk sqrt
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import untuk FontAwesome

class CalculatorIsiPage extends StatefulWidget {
  const CalculatorIsiPage({super.key});

  @override
  _CalculatorIsiPageState createState() => _CalculatorIsiPageState();
}

class _CalculatorIsiPageState extends State<CalculatorIsiPage> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  List<String> history = [];
  String? lastButtonPressed;

  void buttonPressed(String buttonText) {
    setState(() {
      lastButtonPressed = buttonText;
    });

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        lastButtonPressed = null;
      });
    });

    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "backspace_rounded") {
      if (operand.isNotEmpty) {
        operand = "";
        _output = num1.toString().replaceAll(".0", "");
        if (_output.isEmpty || _output == "0") {
          _output = "0";
        }
      } else {
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = "0";
        }
      }

      setState(() {
        output = _output;
      });
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "x") {
      if (_output != "0") {
        num1 = double.parse(output);
      }
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "√") {
      double currentNum = double.parse(_output);
      String result = (sqrt(currentNum)).toStringAsFixed(2); // Akar kuadrat
      _output = result;
      history.add("√$currentNum = $result");
    } else if (buttonText == "^") {
      double currentNum = double.parse(_output);
      String result = (currentNum * currentNum).toString().replaceAll(".0", "");
      _output = result;
      history.add("$currentNum^2 = $result");
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString().replaceAll(".0", "");
      }
      if (operand == "-") {
        _output = (num1 - num2).toString().replaceAll(".0", "");
      }
      if (operand == "x") {
        _output = (num1 * num2).toString().replaceAll(".0", "");
      }
      if (operand == "/") {
        _output = (num1 / num2).toString().replaceAll(".0", "");
      }

      history.add("$num1 $operand $num2 = $_output");
      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText, Color color, {IconData? icon}) {
    bool isPressed = lastButtonPressed == buttonText;
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: NeumorphicButton(
          child: icon != null
              ? Icon(
                  icon,
                  size: 32,
                  color: const Color.fromARGB(255, 12, 0, 0),
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 12, 0, 0),
                  ),
                ),
          color: isPressed ? Color.fromARGB(255, 165, 98, 92) : color,
          onTap: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 210, 152, 173),
        elevation: 0,
        title: Center(
          child: Text(
            'Pert. 7 Calc Kika 152022014',
            style: TextStyle(
              color: Color.fromARGB(212, 9, 1, 0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 255, 253, 204), // Pastel yellow
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromARGB(255, 128, 0, 0), // Maroon color
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              history[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(
                                    255, 251, 155, 0), // White text color
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  operand.isNotEmpty ? "$num1 $operand $output" : output,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _output,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("C", Color.fromARGB(255, 244, 172, 172)),
                  buildButton("√", Color.fromARGB(255, 244, 172, 172),
                      icon: FontAwesomeIcons
                          .squareRootAlt), // Ganti dengan FontAwesomeIcons
                  buildButton(
                      "backspace_rounded", Color.fromARGB(255, 244, 172, 172),
                      icon: FontAwesomeIcons.backspace), // Ikon backspace
                  buildButton("^", Color.fromARGB(255, 244, 172, 172)),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("7", Colors.white),
                  buildButton("8", Colors.white),
                  buildButton("9", Colors.white),
                  buildButton("/", Color.fromARGB(255, 244, 172, 172)),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", Colors.white),
                  buildButton("5", Colors.white),
                  buildButton("6", Colors.white),
                  buildButton("x", Color.fromARGB(255, 244, 172, 172)),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", Colors.white),
                  buildButton("2", Colors.white),
                  buildButton("3", Colors.white),
                  buildButton("-", Color.fromARGB(255, 244, 172, 172)),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("0", Colors.white),
                  buildButton(".", Colors.white),
                  buildButton("=", Color.fromARGB(255, 244, 172, 172)),
                  buildButton("+", Color.fromARGB(255, 244, 172, 172)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NeumorphicButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color color;

  NeumorphicButton(
      {required this.child, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Center(child: child),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(4, 4),
              blurRadius: 15,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
