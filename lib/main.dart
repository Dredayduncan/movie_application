// @dart=2.9

import 'package:flutter/material.dart';
import 'package:movie_app/views/homeScreen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Movie Application',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.blue,
      // ),
      home: SplashScreen(
        useLoader: false,
        photoSize: 50.0,
        backgroundColor: const Color(0xFF40404C),
        seconds: 5,
        navigateAfterSeconds: const Home(),
        image: const Image(
          image: AssetImage("assets/images/Rectangle1.png")
        ),
        title: Text(
            "Moviemot",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = const LinearGradient(
                  colors: <Color>[
                    Color(0xFF40B4C9),
                    Color(0xFFF2555B),
                    //add more color here.
                  ],
                ).createShader(const Rect.fromLTWH(100.0, 0.0, 200.0, 100.0))
            )
        ),
      ),
    );
  }
}


