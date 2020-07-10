import 'package:flutter/material.dart';
import 'package:p_a/screens/home_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'APP Politica',
        theme: ThemeData(
            primarySwatch: Colors.red, primaryColor: Colors.lightBlue),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}
