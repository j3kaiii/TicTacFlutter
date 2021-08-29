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
  bool onTurn = true; // Чей ход? У нас обычно начинают с X

  List<String> sign = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ]; // значек на поле

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
              onTap: () {
                _tapped(index); // в функцию попадает индекс ячейки
              }, // событие при тапе
              child: Container(
                // рисуем плитки поля
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  // с текстом по центру
                  child: Text(
                    sign[index],
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _tapped(int index) {
    // стейт можно изменить только внутри setState
    setState(() {
      if (onTurn) {
        sign[index] = 'X';
      } else {
        sign[index] = 'O';
      }

      onTurn = !onTurn; // переключатель хода между Х и О
      _checkWinner();
    });
  }

  void _checkWinner() {
    // проверяем первую строку
    // все три ячейки одинаковые и при этом не пустые
    if (sign[0] == sign[1] && sign[0] == sign[2] && sign[0] != '') {
      _showWinDialog(sign[0]);
    }
    // вторая строка
    if (sign[3] == sign[4] && sign[3] == sign[5] && sign[3] != '') {
      _showWinDialog(sign[3]);
    }
    // тертья строка
    if (sign[6] == sign[7] && sign[6] == sign[8] && sign[6] != '') {
      _showWinDialog(sign[6]);
    }

    // правый столбец
    if (sign[0] == sign[3] && sign[0] == sign[6] && sign[0] != '') {
      _showWinDialog(sign[0]);
    }
    // средний столбец
    if (sign[1] == sign[4] && sign[1] == sign[7] && sign[1] != '') {
      _showWinDialog(sign[1]);
    }
    // левый столбец
    if (sign[2] == sign[5] && sign[2] == sign[8] && sign[2] != '') {
      _showWinDialog(sign[2]);
    }

    // одна диагональ
    if (sign[0] == sign[4] && sign[0] == sign[8] && sign[0] != '') {
      _showWinDialog(sign[0]);
    }
    // другая диагональ
    if (sign[2] == sign[4] && sign[2] == sign[6] && sign[2] != '') {
      _showWinDialog(sign[2]);
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS $winner'),
          );
        });
  }
}
