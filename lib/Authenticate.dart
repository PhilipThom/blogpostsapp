import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticateImplementation{
  Future<String> SignIn(String email,String password);
  Future<String> Register(String email,String password);
  Future<String> getCurrentLoggedInUser();
  Future<String>signOut();

}
class Authenticate implements AuthenticateImplementation{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  Future<String> SignIn(String email,String password) async{
    FirebaseUser user=(await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;

  }

  Future<String> getCurrentLoggedInUser() async{
    FirebaseUser user =await _firebaseAuth.currentUser();
  }

  Future<String> Register(String email,String password) async{
    FirebaseUser user=(await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;

  }
  Future<String>signOut()async{
    _firebaseAuth.signOut();
  }
}