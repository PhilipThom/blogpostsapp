import 'package:flutter/material.dart';
import 'package:blogposts/Authenticate.dart';
import 'package:blogposts/Home.dart';
import 'package:blogposts/upload_photo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Posts.dart';
class Home extends StatefulWidget {

  Home({this.auth,this.onSignedOut});
  final AuthenticateImplementation auth;
  final VoidCallback onSignedOut;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Posts> postList=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference postref=FirebaseDatabase.instance.reference().child("Posts");

    postref.once().then((DataSnapshot snap){
      var KEYS=snap.value.keys;
      var DATA=snap.value;
      postList.clear();

      for(var individualKey in KEYS){
        Posts posts=new Posts(
          DATA[individualKey]['date'],

          DATA[individualKey]['description'],
          DATA[individualKey]['image'],
          DATA[individualKey]['time'],

        );
        postList.add(posts);
      }
      setState(() {
        print('Length :$postList.length');
      });
    });

  }
  void _logoutUser() async{
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(e){
      print(e.toString());

    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: postList.length==0 ? new Text("No Posts available yet"):new ListView.builder(

          itemCount: postList.length,
          itemBuilder: (_, index){
            return PostsUI(postList[index].date,postList[index].description,postList[index].image, postList[index].time);
          }

        ),

      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Container(
          margin: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize:MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.local_car_wash),

                iconSize: 40,
                color: Colors.white, onPressed: () {
                  _logoutUser();
              },
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                iconSize: 40,
                color: Colors.white, onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPhoto()));
              },
              ),
              IconButton(
                icon: Icon(Icons.home),
                iconSize: 40,
                color: Colors.white, onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              ),
            ],
          ),
        ),

      ),
    );
  }

  Widget PostsUI(String date,String description,String image,String time){
    return Card(
      elevation: 11.0,
      margin: EdgeInsets.all(14.0),

      child: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,style: Theme.of(context).accentTextTheme.subtitle,
                  textAlign: TextAlign.center,

                ),
                Text(
                  time,style: Theme.of(context).accentTextTheme.subtitle,
                  textAlign: TextAlign.center,

                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Image.network(image,fit: BoxFit.cover,),
            SizedBox(height: 10.0,),
            Text(
              description,style: Theme.of(context).accentTextTheme.subhead,
              textAlign: TextAlign.center,

            ),

          ],
        ),

    ),



    );
  }
}

