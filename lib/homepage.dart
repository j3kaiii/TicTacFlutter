import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  static var myFont = GoogleFonts.roboto(
      textStyle: TextStyle(color: Colors.white, fontSize: 30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800], // бэкграунд
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Player X', style: myFont),
                    Text(xScore.toString(), style: myFont)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Player O', style: myFont),
                    Text(oScore.toString(), style: myFont)
                  ],
                ),
              ),
            ]),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                //сетка
                itemCount: 9, // из 9 элементов
                gridDelegate: // 3*3
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
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
          ),
          Expanded(
              child: Container(
            child: Center(
              child: Column(
                children: [
                  Text("Крестики-Нолики", style: myFont),
                  SizedBox(height: 60),
                  Text("@j3kaiii", style: myFont)
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _tapped(int index) {
    // стейт можно изменить только внутри setState
    setState(() {
      if (onTurn && sign[index] == '') {
        sign[index] = 'X';
        filledBoxes++;
      } else if (!onTurn && sign[index] == '') {
        sign[index] = 'O';
        filledBoxes++;
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
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    onTurn = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('NO WINNER'),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again'))
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    onTurn = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS $winner'),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again'))
            ],
          );
        });

    if (winner == 'X') {
      xScore++;
    } else if (winner == 'O') {
      oScore++;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        sign[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
