import 'dart:convert';
import 'package:WallEngine/data/data.dart';
import 'package:WallEngine/model/wallpapermodel.dart';
import 'package:WallEngine/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Categories extends StatefulWidget {
  final String categoryName;
  Categories({this.categoryName});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers(String query) async {
    int pageNumber=1;
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=80&page=$pageNumber",
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
    return query;
  }

  @override
  void initState() {
    getSearchWallpapers(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String query = widget.categoryName.toUpperCase();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                child: Text(
                  "$query",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              wallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
