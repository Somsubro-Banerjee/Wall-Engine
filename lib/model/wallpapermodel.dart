// import 'dart:convert';
class WallpaperModel{
  String photographer;
  String photographer_url;
  int photographer_id;

  SrcModel src;

  WallpaperModel({this.src, this.photographer, this.photographer_id, this.photographer_url});

  factory WallpaperModel.fromMap(Map<String, dynamic> jasonData){
    return WallpaperModel(
      src: SrcModel.fromMap(jasonData["src"]),
      photographer_url: jasonData["photographer_url"],
      photographer_id: jasonData["photographer_id"],
      photographer: jasonData["photographer"],
      );
  }
  
}

class SrcModel{

String original;
String small;
String portrait;

SrcModel({this.original, this.portrait, this.small});

factory SrcModel .fromMap(Map<String, dynamic>jsonData){
  return SrcModel(
    portrait: jsonData["portrait"],
    original: jsonData["original"],
    small: jsonData["small"],
  );
}
}