import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChairpersonPage extends StatefulWidget {
   final VoidCallback onSignedOut;
  ChairpersonPage({this.onSignedOut});
  @override
  _ChairpersonPageState createState() => new _ChairpersonPageState();
}

class _ChairpersonPageState extends State<ChairpersonPage> {
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
        title: new Text('Chairperson Page'),
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
