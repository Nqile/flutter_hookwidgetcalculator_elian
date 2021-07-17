import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

class ButtonChangeNotifier extends ChangeNotifier {
  var userInput = '';
  var answer = '';

  Future<void> clear() async {
    userInput = '';
    answer = '0';
    notifyListeners();
  }

  Future<void> addThis(String s) async {
    userInput += s;
    notifyListeners();
  }

  Future<void> del() async {
    userInput = userInput.substring(0, userInput.length - 1);
    notifyListeners();
  }

  Future<void> equalPressed() async {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();

    notifyListeners();
  }
}
