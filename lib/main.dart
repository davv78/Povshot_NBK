import 'package:flutter/material.dart';
import 'package:povshotnbk/pages/splash_screen.dart';
import 'package:povshotnbk/theme.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: blackColor),
      home: SplashScreen(),
    );  
  }
}