import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const int gridSize = 3; // пока так задал размерность поля

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onTurn = true; // Чей ход? У нас обычно начинают с X

  int oScore = 0; // кол-во побед Ноликов
  int xScore = 0; // кол-во побед Крестиков
  int filledBoxes = 0; // счетчик занятых ячеек
  String winner = ''; // победитель, если такой есть
  bool gameOver = false; // есть победитель?
  int gridLenth = gridSize * gridSize; // общее кол-во ячеек

  // задаем игровое поле в двумерном массиве
  var signGrid = List.generate(gridSize, (index) => List.filled(gridSize, ''));

  // шрифт
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
              child:
                  // в строке отображаем игроков и их счет
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Крестики', style: myFont),
                      Text(xScore.toString(), style: myFont)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Нолики', style: myFont),
                      Text(oScore.toString(), style: myFont)
                    ],
                  ),
                ),
              ]),
            )),
            // игровое поле
            Expanded(
                flex: 3, child: gameOver ? showResult(winner) : showGrid()),
            Expanded(
                // подвал
                child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text("Крестики-Нолики", style: myFont),
                      SizedBox(height: 20),
                      Text("@j3kaiii", style: myFont)
                    ],
                  ),
                ),
              ),
            )),
          ],
        ));
  }

// действия при тапе
  void _tapped(int x, int y) {
    // определяем знак в зависимости от того, чей ход
    String s;
    if (onTurn) {
      s = 'X';
    } else {
      s = 'O';
    }
    setState(() {
      if (signGrid[x][y] == '') {
        signGrid[x][y] = s; // рисуем знак в клетке
        filledBoxes++; // увеличивам счетчик занятых ячеек
        onTurn = !onTurn; // переключатель хода между Х и О
        _checkWinner(s);
      }
    });
  }

  void _checkWinner(String s) {
    if (_checkDiagonal(s) || _checkLines(s)) {
      if (s == 'X') {
        xScore++;
      } else {
        oScore++;
      }
      winner = s;
      gameOver = true;
      _clearBoard();
    } else if (filledBoxes == gridLenth) {
      winner = '';
      gameOver = true;
    }
  }

  // проверка диагоналей
  bool _checkDiagonal(String s) {
    bool toright, toleft;
    toright = true;
    toleft = true;

    for (int i = 0; i < gridSize; i++) {
      toright &= (signGrid[i][i] == s);
      toleft &= (signGrid[gridSize - i - 1][i] == s);
    }
    // если любая диагональ заполнена одинаковыми символами
    return (toright || toleft);
  }

  // проверка линий и столбиков
  bool _checkLines(String s) {
    bool cols, rows;
    for (int col = 0; col < gridSize; col++) {
      cols = true;
      rows = true;
      for (int row = 0; row < gridSize; row++) {
        cols &= (signGrid[col][row] == s);
        rows &= (signGrid[row][col] == s);
      }
      // если есть целая строка или столбец, нашли победителя и вышли
      if (cols || rows) return true;
    }
    return false;
  }

  // очистка доски
  void _clearBoard() {
    setState(() {
      for (int col = 0; col < gridSize; col++) {
        for (int row = 0; row < gridSize; row++) {
          signGrid[col][row] = '';
        }
      }
    });
    onTurn = true; // передаем ход Крестикам
    filledBoxes = 0; // сбрасываем счетчик заполненных ячеек
  }

  Widget showResult(String s) {
    String result;
    if (s == '') {
      result = 'Победителя нет';
    } else if (s == 'X') {
      result = 'Крестики выиграли';
    } else {
      result = 'Нолики выиграли';
    }

    return Container(
        child: Column(
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 50),
          child: Text(result, style: myFont),
        )),
        TextButton(
            onPressed: (() => {winner = '', gameOver = false, _clearBoard()}),
            child: Text(
              'Играть',
              style: TextStyle(fontSize: 20),
            ))
      ],
    ));
  }

  // отрисовка поля
  Widget showGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize,
      ),
      itemCount: gridLenth,
      itemBuilder: (BuildContext context, int index) {
        int x, y = 0;
        x = (index / gridSize).floor();
        y = (index % gridSize);
        return GestureDetector(
          onTap: () {
            _tapped(x, y);
          },
          child: GridTile(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Center(
                child: Text(
                  signGrid[x][y],
                  style: myFont,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
