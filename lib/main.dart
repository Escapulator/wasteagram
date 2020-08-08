import 'package:flutter/material.dart';
import 'package:wasteagram/Screens/AddDetails.dart';
import 'package:wasteagram/Screens/Home.dart';
import 'package:wasteagram/Screens/Splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Splash(),
      title: 'Wasteagram',
      routes: {
        'home': (BuildContext context) => new Home(),
        'Details' : (BuildContext context) => new Details()
      },
    );
  }
}