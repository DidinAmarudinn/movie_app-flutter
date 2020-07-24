import 'package:flutter/material.dart';
import 'package:movie_app/screens/dashboard.dart';
import 'package:movie_app/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:  Color.fromRGBO(28,28,28,1),
      ),
      home: HomePage(),
    );
  }
}