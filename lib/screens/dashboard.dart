import 'package:flutter/material.dart';
import 'package:movie_app/widgets/genres_widget.dart';
import 'package:movie_app/widgets/nowplaying_widget.dart';
import 'package:movie_app/widgets/popular_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CarouselWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Genres",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GenresWidget(),
              PopularWidget()
            ],
          ),
        ),
      ),
    );
  }
}
