import 'package:flutter/material.dart';
import 'package:movie_app/widgets/list_category_widget.dart';

class CategoryScreen extends StatefulWidget {
  final String idCategory;
  final String imageUrlCategory;
  final String categoryName;

  CategoryScreen({this.idCategory, this.imageUrlCategory, this.categoryName});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: widget.imageUrlCategory + widget.idCategory,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                    child: Image(
                      height: height * 0.35,
                      width: double.infinity,
                      image: NetworkImage(widget.imageUrlCategory),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color:
                                Color.fromRGBO(229, 16, 22, 1).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
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
                          child: Text(
                            widget.categoryName + " Category",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 180),
                  child: ListCategoryWidget(widget.idCategory),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
