import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flushbar/flushbar.dart';
class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({this.imgUrl});

  // final String photographerName;
  // ImageView({this.photographerName});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _save();
                      // Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [Colors.black45, Colors.black38])),
                      child: Column(
                        children: [
                          Text(
                            "Download",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          child: Text("Close",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)))),
                  SizedBox(
                    height: 16,
                  )
                ],
              ))
        ],
      ),
    );
  }

  _save() async {

   try {
      if (Platform.isAndroid) {
      await _askPermission();
    }

    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));

      FlutterFlexibleToast.showToast(
        message: "Download complete file stored in $result",
        toastLength: Toast.LENGTH_LONG,
        toastGravity: ToastGravity.BOTTOM,
        icon: ICON.SUCCESS,
        radius: 100,
        elevation: 10,
        imageSize: 35,
        textColor: Colors.black,
        fontSize: 15,
        backgroundColor: Colors.white,
        timeInSeconds: 5,
      );

      Flushbar(
      title: "Download Complete",
      message: "Image has been saved Successfully in : $result",
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.black,
      boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      isDismissible: true,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.photo,
        color: Colors.red,
      ),
      
     
    )..show(context);
    print(result);
   } catch (e) {
     Flushbar(
      title: "Cannot download image, please check internet connection",
      message: "Error: $e",
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      isDismissible: true,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.error,
        color: Colors.black,
      ),
    )..show(context);
   }

    // Navigator.pop(context);
  }

  _askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.storage,
    ].request();
    print(statuses[Permission.photos]);
    print(statuses[Permission.storage]);
  }
}
