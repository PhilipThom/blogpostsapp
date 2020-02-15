import 'package:blogposts/Mapping.dart';
import 'package:flutter/material.dart';
import 'package:blogposts/LoginRegister.dart';
import 'package:blogposts/Home.dart';
import 'package:blogposts/Authenticate.dart';
import 'package:splashscreen/splashscreen.dart';
//0xFF399063
void main(){
  runApp(BlogApp());
}
class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text("Welcome to blogposts app",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
      ),

      seconds: 9,
      navigateAfterSeconds: MappingPage(auth: Authenticate(),),
      image: new Image.asset('assets/loading.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 150.0,
      onClick: ()=>print("Blog posts app"),
      loaderColor: Colors.white,
    );

//    return MaterialApp(

//
//      title: "Blog App",
//
//      theme: ThemeData(
//        primarySwatch: Colors.green[0xFF399063]
//      ),
//      home: MappingPage(auth: Authenticate(),),
//    );
  }
}
