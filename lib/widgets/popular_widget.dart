import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/models/now_playing_model.dart';
import 'package:http/http.dart' as http;

class PopularWidget extends StatefulWidget {
  @override
  _PopularWidgetState createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  NowPlyingModel nowPlyingModel;
  var url =
      "https://api.themoviedb.org/3/movie/popular?api_key=9838fcc1b588f75f0490e0b4781facd6&language=en-US&page=1";
  Future<void> getPopular() async {
    var res = await http.get(url);
    var decodeJson = jsonDecode(res.body);
    nowPlyingModel = NowPlyingModel.fromJson(decodeJson);
    print(nowPlyingModel.results[1].title);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 0, 0),
          child: Text(
            "PopularMovie",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        nowPlyingModel == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: StaggeredGridView.countBuilder(
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: ClampingScrollPhysics(),
                  itemCount: nowPlyingModel.results.length,
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.5 : 1.3);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    "http://image.tmdb.org/t/p/w185"+nowPlyingModel.results[index].posterPath,
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.black.withOpacity(0.5)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 60,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(12)),
                                    color: Color.fromRGBO(229, 16, 22, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      nowPlyingModel.results[index].voteAverage
                                              .toString() +
                                          " ⭐",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
      ],
    );
  }
}
