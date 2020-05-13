import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_management_system/Classes/Constants.dart';
import 'package:university_management_system/Classes/User.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a Value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.tealAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class UpdateCampusPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  UpdateCampusPage({this.onSignedOut});
  @override
  _UpdateCampusPageState createState() => new _UpdateCampusPageState();
}

class _UpdateCampusPageState extends State<UpdateCampusPage> {
  int _id;
  String _campus;


  void signOut(BuildContext context) async {
    try {
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
        title: Text("Update Campus"),
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
      body: new Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 200, 20, 200),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new TextField(
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "User ID"),
                        onChanged: (value) {
                          setState(() {
                            _id = int.parse(value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new TextField(
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter new Campus"),
                        onChanged: (value) {
                          setState(() {
                            _campus = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: Text('Update student campus'),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                        elevation: 10.0,
                        onPressed: () {
                          User().updateCampus(_campus, _id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
