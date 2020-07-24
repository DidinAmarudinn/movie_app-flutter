import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/now_playing_model.dart';
import 'package:movie_app/screens/detail_screen.dart';

class ListCategoryWidget extends StatefulWidget {
  final String idCategory;
  ListCategoryWidget(this.idCategory);
  @override
  _ListCategoryWidgetState createState() => _ListCategoryWidgetState();
}

class _ListCategoryWidgetState extends State<ListCategoryWidget> {
  bool _loading = true;
  NowPlyingModel nowPlyingModel;
  Future<void> getListCategory(String url) async {
    var res = await http.get(url);
    var decodeJson = jsonDecode(res.body);
    nowPlyingModel = NowPlyingModel.fromJson(decodeJson);
    print(nowPlyingModel.results[2].originalTitle);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    var url =
        "https://api.themoviedb.org/3/discover/movie?api_key=9838fcc1b588f75f0490e0b4781facd6&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=" +
            widget.idCategory;
    getListCategory(url);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: nowPlyingModel.results.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DetailScreen(
                        id: nowPlyingModel.results[index].id.toString(),
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 4, 12, 10),
                      height: 170,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(57, 58, 69, 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 90),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    child: Text(
                                      nowPlyingModel.results[index].title,
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 70,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(229, 16, 22, 1),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          topRight: Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        nowPlyingModel
                                                .results[index].voteAverage
                                                .toString() +
                                            " ⭐",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "Overview",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Container(
                              height: 45,
                              margin: EdgeInsets.only(right: 12, top: 4),
                              child: SingleChildScrollView(
                                child: Text(
                                  nowPlyingModel.results[index].overview,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.amber,
                                ),
                              ),
                              child: Text(
                                nowPlyingModel.results[index].releaseDate,
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 15,
                      bottom: 15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "http://image.tmdb.org/t/p/w185" +
                              nowPlyingModel.results[index].posterPath,
                          errorWidget: (context, url, error) => Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }
}
