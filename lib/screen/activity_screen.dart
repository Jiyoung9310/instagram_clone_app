import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
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
        child: Text('ActivityScreen'),
      ),
    );
  }
}
