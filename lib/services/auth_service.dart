import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/models/user_data.dart';
import 'package:provider/provider.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;

  static void signUpUser (BuildContext context, String name, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if(user!=null) {
        _firestore.collection('/users').document(user.uid).setData({
          'name': name,
          'email': email,
          'profileImageUrl': '',
        });
        Provider.of<UserData>(context).currentUserId = user.uid;
        Navigator.pop(context);
      }
    } catch(e) {
      print(e);
    }

  }

  static void logout (BuildContext context) {
    _auth.signOut();
    //Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  static void login (String email, String password) async {
    try{
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch(e) {
      print(e);
    }
  }
}