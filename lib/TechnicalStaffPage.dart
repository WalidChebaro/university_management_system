import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TechnicalStaffPage extends StatefulWidget {
   final VoidCallback onSignedOut;
  TechnicalStaffPage({this.onSignedOut});
  @override
  _TechnicalStaffPageState createState() => new _TechnicalStaffPageState();
}

class _TechnicalStaffPageState extends State<TechnicalStaffPage> {
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
        title: new Text('TechnicalStaff Page'),
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
