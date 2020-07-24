import 'package:flutter/material.dart';
import 'package:movie_app/screens/dashboard.dart';
import 'package:movie_app/screens/drawer_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DrawerScreen(),
          Dashboard()
        ],
      ),
    );
  }
}