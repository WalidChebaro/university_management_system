import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_management_system/Classes/Staff.dart';

class RegistrarPage extends StatefulWidget {
   final VoidCallback onSignedOut;
   final Staff staff;
  RegistrarPage({this.onSignedOut, this.staff});
  @override
  _RegistrarPageState createState() => new _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
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
        title: new Text('Registrar Page'),
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
