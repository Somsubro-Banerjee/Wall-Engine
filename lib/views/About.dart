import 'package:WallEngine/widgets/widget.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            brandName(), 
            SizedBox(height:20),
            Text("Made with 💝", style: TextStyle(color: Colors.white, fontSize: 20),),
            SizedBox(height:20),
            Text("Powered by PEXELS API", style: TextStyle(color: Colors.white, fontSize: 20),),
            SizedBox(height:20),
            IconButton(icon: Icon(Icons.arrow_back, color: Colors.white, size: 25,), onPressed: (){
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  }
}