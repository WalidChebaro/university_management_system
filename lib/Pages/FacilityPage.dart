import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_management_system/Classes/Constants.dart';

class FacilityPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  FacilityPage({this.onSignedOut});
  @override
  _FacilityPageState createState() => new _FacilityPageState();
}

class _FacilityPageState extends State<FacilityPage> {
  // String _petitiontitle;
  // String _petitiontype;
  // String _petitioncontent;
  void signOut(BuildContext context) async {
    try {
      Navigator.pop(context);
      await FirebaseAuth.instance.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Facility"),
        backgroundColor: Colors.teal[400],
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(
              Icons.dehaze,
            ),
          )
        ],
      ),
    );
  }
}
