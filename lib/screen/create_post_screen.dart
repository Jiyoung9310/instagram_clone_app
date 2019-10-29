import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
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
      body: Center(
        child: Text('CreatePostScreen'),
      ),
    );
  }
}
