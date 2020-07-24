import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/genres_model.dart';
import 'package:movie_app/screens/category_screen.dart';

class GenresWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12),
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, int index) {
          return CategoryTile(
            id: genres[index].id,
            imgUrl: genres[index].imgUrl,
            name: genres[index].name,
          );
        },
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String id;
  CategoryTile({this.name, this.id, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CategoryScreen(
              idCategory: id,
              imageUrlCategory: imgUrl,
              categoryName: name,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            Hero(
              tag: imgUrl + id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 120,
                  height: 60,
                  imageUrl: imgUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Container(
              width: 120,
              height: 60,
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
