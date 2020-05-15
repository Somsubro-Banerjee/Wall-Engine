import 'package:WallEngine/views/imageView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:WallEngine/model/wallpapermodel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
int counter = 3;

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Wall",
        style: TextStyle(color: Colors.white, fontSize: 28, letterSpacing: 3),
      ),
      SizedBox(width: 10),
      Text(
        "Engine",
        style: TextStyle(color: Colors.amber, fontSize: 13, letterSpacing: 3),
      ),
    ],
  );
}

@override
void initState() {
  wallpapersList();
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      crossAxisCount: counter,
      childAspectRatio: 0.67,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              // print(wallpaper.src.portrait);
              print(wallpapers.length);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imgUrl: wallpaper.src.portrait,
                          )
                          )
                          );
            },
            child: Stack(
              children: [
                GestureDetector(
                    child: CachedNetworkImage(
                    imageUrl: wallpaper.src.portrait,
                    imageBuilder: (context, imageProvider) => Container(
                      child: Hero(
                        tag: wallpaper.src.portrait,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: wallpaper.src.portrait,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    fadeInCurve: Curves.elasticIn,
                    fadeOutCurve: Curves.elasticOut,
                    fadeInDuration: Duration(milliseconds: 4000),
                    fadeOutDuration: Duration(milliseconds: 4000),
                    placeholder: (context, url) =>
                        Center(child: SpinKitThreeBounce(
                          color: Colors.blue,
                          size: 30,
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      ).toList(),
    ),
  );
}


Widget categoryRow() {
  return Container(
    alignment: Alignment.topLeft,
    padding: EdgeInsets.all(20),
    child: Text(
      "Categories",
      style: TextStyle(color: Colors.white, fontSize: 15),
    ),
  );
}
