import 'package:flutter/material.dart';
import 'package:ride/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZNU Ride',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      routes: {'/': (context) => HomeScreen()},
    );
  }
}
