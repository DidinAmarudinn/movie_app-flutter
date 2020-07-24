import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/now_playing_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/detail_screen.dart';

class CarouselWidget extends StatefulWidget {
  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int current = 0;
  NowPlyingModel nowPlyingModel;
  var url =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=9838fcc1b588f75f0490e0b4781facd6&language=id-IDN&page=1";
  Future<void> getListNowPlaying() async {
    var res = await http.get(url);
    var decodeJson = jsonDecode(res.body);
    nowPlyingModel = NowPlyingModel.fromJson(decodeJson);
    setState(() {});
  }
  Text _buildRating(dynamic rating) {
    String stars = '';
    for (int i = 0; i < rating.round() /2; i++) {
      stars += '⭐ ';
    }
    return Text(stars);
  }

  @override
  void initState() {
    super.initState();
    getListNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: <Widget>[
                Text(
                  "Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Playing",
                  style: TextStyle(
                    color: Color.fromRGBO(229, 16, 22, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          nowPlyingModel == null
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    CarouselSlider(
                      items: nowPlyingModel.results
                          .map(
                            (e) => Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      "http://image.tmdb.org/t/p/w185" +
                                          e.backdropPath,
                                      fit: BoxFit.cover,
                                      width: width,
                                      height: height * 04,
                                    ),
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.white.withOpacity(0.2),
                                              Color.fromARGB(0, 0, 0, 0)
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              e.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "⭐ "+e.voteAverage.toString() + " / 10" ,style: TextStyle(color: Colors.white70),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              current = index;
                            });
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: nowPlyingModel.results.map(
                        (e) {
                          int index = nowPlyingModel.results.indexOf(e);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: current == index
                                  ? Colors.white
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
