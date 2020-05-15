import 'dart:convert';
import 'dart:ui';
import 'package:WallEngine/data/data.dart';
import 'package:WallEngine/model/CaegoriesModel.dart';
import 'package:WallEngine/model/wallpapermodel.dart';
import 'package:WallEngine/views/About.dart';
import 'package:WallEngine/views/home.dart';
import 'package:WallEngine/views/search.dart';
import 'package:WallEngine/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeRecrated extends StatefulWidget {
  @override
  _HomeRecratedState createState() => _HomeRecratedState();
}

class _HomeRecratedState extends State<HomeRecrated> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();
  getTrendingWallpapers() async {
    int pageNumber = 1;
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=80&page=$pageNumber",
        headers: {
          "Authorization": apiKey,
        });
    print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color someColor = Color(0xff694ba1);
    return Scaffold(
      drawer: Drawer(
          elevation: 0.0,
          child: Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "About",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxISScrolled) {
          return <Widget>[
            SliverAppBar(
              brightness: Brightness.dark,
              elevation: 2.0,
              centerTitle: true,
              stretch: innerBoxISScrolled,
              snap: true,
              backgroundColor: Colors.black,
              expandedHeight: 80,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: brandName(),
              ),
            )
          ];
        },
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height/14,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Container(
                decoration: BoxDecoration(
                  color: someColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal:24),
                child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      
                      autofocus: false,
                      autocorrect: true,
                      enableInteractiveSelection: true,
                      controller: searchController,
                      cursorColor: Colors.amber,
                      decoration: InputDecoration(
                        hintText: "Search 🚀 ",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                  searchQuery: searchController.text,
                                )
                            )
                        );
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      )
                    )
                  ],
                ),
              )
            ),
            SingleChildScrollView(
              child:   Container(
                // color: Colors.green,
                  child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                          child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1), 
                          child: categoryRow(),
                        ),
                      ),          
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 80,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return categoryTile(
                          title: categories[index].categoriesName,
                          imgUrl: categories[index].imgUrl,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  wallpapersList(wallpapers: wallpapers, context: context),

                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
