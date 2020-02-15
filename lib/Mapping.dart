import 'package:flutter/material.dart';
import 'package:blogposts/LoginRegister.dart';
import 'package:blogposts/Home.dart';
import 'Authenticate.dart';


class MappingPage extends StatefulWidget{
  final AuthenticateImplementation auth;
  MappingPage({
    this.auth,
});

  State<StatefulWidget> createState(){
    return _MappingPageState();
  }
}

enum AuthStatus{
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentLoggedInUser().then((firebaseUserId) {
      setState(() {
        authStatus =
        firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

   void _signedIn(){
    setState(() {
      authStatus=AuthStatus.signedIn;
    });
   }
  void _signOut(){
    setState(() {
      authStatus=AuthStatus.notSignedIn;
    });
  }
    @override
    Widget build(BuildContext context) {
       switch(authStatus){
         case AuthStatus.notSignedIn:
           return Login(
             auth: widget.auth,
             onSignedIn: _signedIn

           );
         case AuthStatus.signedIn:
           return Home(
               auth: widget.auth,

               onSignedOut: _signOut

           );
       }
       return null;

    }


}
