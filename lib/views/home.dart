import 'dart:convert';
import 'dart:ui';
import 'package:WallEngine/data/data.dart';
import 'package:WallEngine/model/CaegoriesModel.dart';
import 'package:WallEngine/model/wallpapermodel.dart';
import 'package:WallEngine/views/About.dart';
import 'package:WallEngine/views/category.dart';
import 'package:WallEngine/views/search.dart';
import 'package:WallEngine/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  List<WallpaperModel> stuff = new List();

  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async {
    int pageNumber = 1;
    
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=80&page=$pageNumber",
        headers: {
          "Authorization": apiKey,
          }
        );
        
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
  Color buttonColor = Colors.white;

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: brandName(),
          elevation: 0.0,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: Colors.amber),
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
                      ))
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                categoryRow(),
                SizedBox(width: 200),           
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
            // wallpapersNewList(wallpapers: wallpapers, context: context),
          ],
        )),
      ),
    );
  }
}

class categoryTile extends StatelessWidget {
  categoryTile({@required this.title, @required this.imgUrl});

  final String imgUrl, title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categories(
                      categoryName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.shade300.withOpacity(1)),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Image.network(
                        imgUrl,
                        height: 80,
                        width: 150,
                        fit: BoxFit.cover,
                      ))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 80,
              width: 150,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


