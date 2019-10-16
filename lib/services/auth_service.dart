import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static void signUpUser (
      BuildContext context,
      String name,
      String email,
      String password
      ) {

  }
}