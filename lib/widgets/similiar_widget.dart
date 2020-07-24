import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/now_playing_model.dart';
import 'package:movie_app/screens/detail_screen.dart';

class SimiliarWidget extends StatefulWidget {
  final String id;
  SimiliarWidget(this.id);
  @override
  _SimiliarWidgetState createState() => _SimiliarWidgetState();
}

class _SimiliarWidgetState extends State<SimiliarWidget> {
  NowPlyingModel nowPlyingModel;
  Future<void> getDataSimiliar(String url) async {
    var res = await http.get(url);
    var decodeJson = jsonDecode(res.body);
    nowPlyingModel = NowPlyingModel.fromJson(decodeJson);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    var url =
        "https://api.themoviedb.org/3/movie/${widget.id}/recommendations?api_key=9838fcc1b588f75f0490e0b4781facd6&language=en-US&page=1";
    getDataSimiliar(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: nowPlyingModel == null
          ? Center(
            child: CircularProgressIndicator(),
          )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: nowPlyingModel.results.length,
              scrollDirection: Axis.horizontal,
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: nowPlyingModel.results[index].posterPath == null
                        ? Icon(
                            Icons.broken_image,
                            size: 80,
                            color: Colors.white,
                          )
                        : ClipRRect(
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
                  ),
                );
              },
            ),
    );
  }
}
