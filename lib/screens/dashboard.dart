import 'package:flutter/material.dart';
import 'package:movie_app/widgets/genres_widget.dart';
import 'package:movie_app/widgets/nowplaying_widget.dart';
import 'package:movie_app/widgets/popular_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color.fromRGBO(28, 28, 28, 1),
            borderRadius: isOpen
                ? BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(0))
                : BorderRadius.circular(0)),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        duration: Duration(milliseconds: 250),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    isOpen
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                isOpen = false;
                                scaleFactor = 1;
                              });
                            })
                        : IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                xOffset = 200;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isOpen = true;
                              });
                            },
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Movie",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(
                          "Discover",
                          style: TextStyle(
                              color: Color.fromRGBO(229, 16, 22, 1),
                              fontSize: 22),
                        )
                      ],
                    ),
                    CircleAvatar(
                        backgroundImage: NetworkImage("https://scontent.fcgk3-2.fna.fbcdn.net/v/t1.0-9/51168193_1084901925043296_2991759611486273536_n.jpg?_nc_cat=107&_nc_sid=09cbfe&_nc_eui2=AeE4o7BWBdS0ULImidx-7hhiezNSBGJZKAp7M1IEYlkoCqd7PWzRG-Dm4X4KI2Og8GotCmmY1s8X3sT4i7d3bVaI&_nc_ohc=E9STmO_hKvgAX8GroRz&_nc_ht=scontent.fcgk3-2.fna&oh=e9f7095f29d2b81a170b130c46f1f180&oe=5F3E884C"),
                      )
                  ],
                ),
              ),
              Column(
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
                 Container(
                   decoration: BoxDecoration(
                     borderRadius:isOpen?  BorderRadius.circular(40) :BorderRadius.circular(0)
                   ),
                   child:  PopularWidget(),
                 )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
