import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // точка входа в приложение
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // убираем банер 'debug'
      home: HomePage(), // рисуем виджет
    );
  }
}

class HomePage extends StatefulWidget {
  // создаем стейт для изменяемого виджета
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sign = 'X'; // значек на поле

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800], // бэкграунд
      body: GridView.builder(
          //сетка
          itemCount: 9, // из 9 элементов
          gridDelegate: // 3*3
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              // ловим тап
              onTap: _tapped, // событие при тапе
              child: Container(
                // рисуем плитки поля
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  // с текстом по центру
                  child: Text(
                    sign,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _tapped() {
    // стейт можно изменить только внутри setState
    setState(() {
      sign = 'O';
    });
  }
}
