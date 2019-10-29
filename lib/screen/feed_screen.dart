import 'package:flutter/material.dart';
import 'package:instagram_clone_app/services/auth_service.dart';

class FeedScreen extends StatefulWidget {
  static final String id = 'feed_screen';
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Instagram',
          style: TextStyle(
              color: Colors.black, fontSize: 35.0, fontFamily: 'Billabong'),
        ),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: FlatButton(
          onPressed: () => AuthService.logout(context),
          child: Text('Logout')
        )
      ),
    );
  }
}
