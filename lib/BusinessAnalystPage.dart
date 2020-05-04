import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BusinessAnalystPage extends StatefulWidget {
   final VoidCallback onSignedOut;
  BusinessAnalystPage({this.onSignedOut});
  @override
  _BusinessAnalystPageState createState() => new _BusinessAnalystPageState();
}

class _BusinessAnalystPageState extends State<BusinessAnalystPage> {
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
        title: new Text('BusinessAnalyst Page'),
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
