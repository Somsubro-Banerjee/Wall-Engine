import 'package:WallEngine/views/imageView.dart';
import 'package:flutter/material.dart';
import 'package:WallEngine/model/wallpapermodel.dart';

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
      // Text(
      //   "Powered by PEXELS",
      //   style: TextStyle(color:Colors.white, fontSize: 8, letterSpacing: 2)
      // ),
    ],
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imgUrl: wallpaper.src.portrait,
                          )));
            },
            child: Container(
              child: Hero(
                tag: wallpaper.src.portrait,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      wallpaper.src.portrait,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
