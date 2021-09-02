import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'about.dart';
import 'homepage.dart';

class IntroScreen extends StatefulWidget {
  // создаем стейт для изменяемого виджета
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  static var myFont = GoogleFonts.roboto(
      textStyle: TextStyle(color: Colors.white, fontSize: 30));
  static var myBlackFont = GoogleFonts.roboto(
      textStyle: TextStyle(color: Colors.black, fontSize: 30));

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
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Container(
                      child: Text('КРЕСТИКИ - НОЛИКИ', style: myFont)),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: AvatarGlow(
                        endRadius: 140,
                        glowColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                style: BorderStyle.none,
                              ),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            child: Image.asset('lib/images/ttt.png',
                                fit: BoxFit.scaleDown),
                            radius: 80,
                          ),
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Center(
                              child: Text(
                            'ИГРАТЬ',
                            style: myBlackFont,
                          )),
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Center(
                            child: Text(
                          'Об авторе',
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
