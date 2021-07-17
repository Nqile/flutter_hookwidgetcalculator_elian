import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'buttons.dart';
import 'calc_model.dart';

void main() => runApp(ProviderScope(child: MyApp()));

T useChangeNotifierListenable<T extends ChangeNotifier>(T data) {
  final state = useState<T>(data);
  return useListenable(state.value);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final buttonChangeNotifier =
        useChangeNotifierListenable(ButtonChangeNotifier());

    final List<String> buttons = [
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

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ), //AppBar
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${buttonChangeNotifier.userInput}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${buttonChangeNotifier.answer}',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    String s = buttons[index];

                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          _clearCalc(buttonChangeNotifier);
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }

                    // +/- button
                    else if (index == 1) {
                      return MyButton(
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          _addToCalc(buttonChangeNotifier, buttons[index]);
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Delete Button
                    else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          _delCalc(buttonChangeNotifier);
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          _equalCalc(buttonChangeNotifier);
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    }

                    // other buttons
                    else {
                      return MyButton(
                        buttontapped: () {
                          _addToCalc(buttonChangeNotifier, buttons[index]);
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }), // GridView.builder
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

  Future<void> _clearCalc(ButtonChangeNotifier buttonChangeNotifier) async {
    buttonChangeNotifier.clear();
  }

  Future<void> _addToCalc(
      ButtonChangeNotifier buttonChangeNotifier, String s) async {
    buttonChangeNotifier.addThis(s);
  }

  Future<void> _delCalc(ButtonChangeNotifier buttonChangeNotifier) async {
    buttonChangeNotifier.del();
  }

  Future<void> _equalCalc(ButtonChangeNotifier buttonChangeNotifier) async {
    buttonChangeNotifier.equalPressed();
  }
}
