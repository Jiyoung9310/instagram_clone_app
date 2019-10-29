import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/screen/feed_screen.dart';
import 'package:instagram_clone_app/screen/login_screen.dart';
import 'package:instagram_clone_app/screen/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/user_data.dart';
import 'screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => UserData(),
      child: MaterialApp(
        title: 'Instagram clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: Colors.black)),
        home: _getScreenId(),
        routes: {
          LoginScreen.id : (context) => LoginScreen(),
          SignUpScreen.id : (context) => SignUpScreen(),
          FeedScreen.id : (context) => FeedScreen(),
        },
      ),
    );
  }
}
