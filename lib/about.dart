import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'introscreen.dart';

class AboutScreen extends StatefulWidget {
  // создаем стейт для изменяемого виджета
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  static var myFont = GoogleFonts.roboto(
      textStyle: TextStyle(color: Colors.white, fontSize: 30));
  static var mySmallFont = GoogleFonts.roboto(
      textStyle: TextStyle(color: Colors.white, fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/evgen.jpg',
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                      Text('Привет! Меня зовут Евгений.', style: mySmallFont),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Пишу на Dart/Flutter уже 3 дня!',
                    style: mySmallFont,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IntroScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 15.0),
                        child: Center(
                            child: Text(
                          'Назад',
                          style: myFont,
                        )),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
