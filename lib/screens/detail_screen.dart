import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/api_key.dart';
import 'package:movie_app/models/detail_model.dart';
import 'package:movie_app/models/now_playing_model.dart';
import 'package:movie_app/widgets/similiar_widget.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  DetailScreen({this.id});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _loading = true;
  DetailModel detailModel;
  Future<void> getDetails(String url) async {
    var res = await http.get(url);
    var decodeJSon = jsonDecode(res.body);
    detailModel = DetailModel.fromJson(decodeJSon);
    print(detailModel.title);
    print(detailModel.id);
    setState(() {
      _loading = false;
    });
  }
String apikey=ApiKey().getApikey();
  @override
  void initState() {
    super.initState();
    var url =
        "https://api.themoviedb.org/3/movie/${widget.id}?api_key=$apikey&language=en-US";
    getDetails(url);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: height * 0.45,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: <Widget>[
                              Image(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(detailModel.backdropPath ==
                                        null
                                    ? "http://image.tmdb.org/t/p/original" +
                                        detailModel.posterPath
                                    : "http://image.tmdb.org/t/p/original" +
                                        detailModel.backdropPath.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(229, 16, 22, 1)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_back,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 12,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: height * 0.225,
                                child: Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: height * 0.20,
                                          width: 120,
                                          imageUrl:
                                              "http://image.tmdb.org/t/p/w185" +
                                                  detailModel.posterPath),
                                    ),
                                    Positioned(
                                      left: 35,
                                      bottom: 0,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color:
                                                Color.fromRGBO(229, 16, 22, 1)),
                                        child: Center(
                                          child: Icon(
                                            Icons.play_circle_outline,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.085, left: 12, right: 12),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  margin: EdgeInsets.only(right: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        detailModel.title,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: ClampingScrollPhysics(),
                                        child: Row(
                                          children: detailModel.genres
                                              .map(
                                                (name) => SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 8),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 6,
                                                            horizontal: 6),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                        width: 0.5,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "#" + name.name,
                                                      style: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        detailModel.releaseDate,
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Rating " +
                                            detailModel.voteAverage.toString() +
                                            " / 10",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Synopsis",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                detailModel.overview,
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    letterSpacing: 0.6),
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Productions Company",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                child: Row(
                                  children: detailModel.productionCompanies
                                      .map(
                                        (e) => Container(
                                          padding: EdgeInsets.all(4),
                                          height: 40,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  color: Colors.amber,
                                                  width: 0.5)),
                                          margin: EdgeInsets.only(right: 8),
                                          child: Center(
                                            child: Text(
                                              e.name,
                                              overflow: TextOverflow.clip,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Similiar like this",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SingleChildScrollView(
                                  physics: ClampingScrollPhysics(),
                                  child: SimiliarWidget(widget.id))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
