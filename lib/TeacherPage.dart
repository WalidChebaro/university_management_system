import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherPage extends StatefulWidget {
   final VoidCallback onSignedOut;
  TeacherPage({this.onSignedOut});
  @override
  _TeacherPageState createState() => new _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Teacher Page'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              signOut(context);
            }),
      ),
      body: Text("landing page"),
    );
  }
}
