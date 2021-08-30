import 'package:flutter/material.dart';
import 'introscreen.dart';

void main() {
  runApp(MyApp()); // точка входа в приложение
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // убираем банер 'debug'
      home: IntroScreen(), // рисуем виджет
    );
  }
}
