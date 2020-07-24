import 'package:flutter/material.dart';
import 'package:movie_app/models/nav_model.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      color: Color.fromRGBO(57, 58, 69, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Hero(
                tag: "imageProfile",
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      "https://scontent.fcgk3-2.fna.fbcdn.net/v/t1.0-9/51168193_1084901925043296_2991759611486273536_n.jpg?_nc_cat=107&_nc_sid=09cbfe&_nc_eui2=AeE4o7BWBdS0ULImidx-7hhiezNSBGJZKAp7M1IEYlkoCqd7PWzRG-Dm4X4KI2Og8GotCmmY1s8X3sT4i7d3bVaI&_nc_ohc=E9STmO_hKvgAX8GroRz&_nc_ht=scontent.fcgk3-2.fna&oh=e9f7095f29d2b81a170b130c46f1f180&oe=5F3E884C"),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Didin Amarudin",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Software Devloper",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: drawerItems
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          e['icon'],
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          e['title'],
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Row(
            children: <Widget>[
              Text(
                "Copyright",
                style: TextStyle(color: Colors.white60),
              ),
              Icon(
                Icons.copyright,
                size: 10,
                color: Colors.white60,
              ),
              Text(
                "2020",
                style: TextStyle(color: Colors.white60),
              )
            ],
          )
        ],
      ),
    );
  }
}
