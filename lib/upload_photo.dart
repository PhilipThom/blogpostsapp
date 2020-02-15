import 'package:blogposts/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class UploadPhoto extends StatefulWidget {
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File sampleImage;
  String myValue;
  String url;
  final formKey=new GlobalKey<FormState>();
  bool validateAndSubmit(){
    final form=formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  void uploadStatusImage() async{
    if(validateAndSubmit()) {
      final StorageReference postedImageRef = FirebaseStorage.instance.ref()
          .child("Image Posts");
      var timeKey = new DateTime.now();
      final StorageUploadTask storageUploadTask = postedImageRef.child(
          timeKey.toString() + ".jpg").putFile(sampleImage);
      var ImageUrl = await (await storageUploadTask.onComplete).ref
          .getDownloadURL();
      url = ImageUrl.toString();
      print("Image Url" + url);

      goToHome();
      saveToDatabase(url);
    }


    }


    void saveToDatabase(url){
      var dbTimeKey=new DateTime.now();
      var formatDate=new DateFormat('MMM d, yyyy');
      var formatTime=new DateFormat('EEEE, hh:mm aaa');

      String date=formatDate.format(dbTimeKey);
      String time=formatTime.format(dbTimeKey);

      DatabaseReference reference=FirebaseDatabase.instance.reference();
      var data={
        "image":url,
        "description":myValue,
        "date":date,
        "time": time,

      };

      reference.child("Posts").push().set(data);
    }

    void goToHome(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));

    }

  Future getImage() async{
    var tempImage=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage=tempImage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Padding(

        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Upload Your Post",style: TextStyle(
              fontSize: 45,fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 100.0,),
            sampleImage==null? Text("Select image to upload"):enableUpload(),
            
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: Icon(Icons.add_a_photo),
        
      ),
    );
  }
  Widget enableUpload(){
    return Container(
      child: Form(

        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(sampleImage,height: 330.0,width: 660.0,),

            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Image description required';
                }
                return null;
              },
              onSaved: (value){
                return myValue=value;
              },




//      key: formKey,
//      validator: (value){
//        return value.isEmpty ? 'Email is required' :null;
//      },

              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(
                  color: Color(0xFFBDC2BC),
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 15.0,),

            RaisedButton(
              color: Colors.deepOrange,
              child: Text("Post"),
              textColor: Colors.white70,
              elevation: 12.0,
              onPressed: () {
                uploadStatusImage();
              },

            )
          ],
        ),
      ),
    );

  }
}
