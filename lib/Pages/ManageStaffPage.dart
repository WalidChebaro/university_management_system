import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university_management_system/Classes/Constants.dart';
import 'package:university_management_system/Pages/AddStaffPage.dart';
import 'package:university_management_system/Pages/UpdateCampusPage.dart';
import 'package:university_management_system/Pages/UpdateOfficePage.dart';
import 'package:university_management_system/Pages/UpdateRolePage.dart';

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

class ManageStaffPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  ManageStaffPage({this.onSignedOut});
  @override
  _ManageStaffPageState createState() => new _ManageStaffPageState();
}

class _ManageStaffPageState extends State<ManageStaffPage> {
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
        title: Text("Manage Staff"),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonTheme(
                      minWidth: 150.0,
                      height: 150.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                                color: Colors.teal[400], width: 2.5)),
                        child: Expanded(
                          child: Column(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Update Staff Office",
                                      style: GoogleFonts.roboto(
                                        color: Colors.teal[400],
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.system_update_alt,
                                      color: Colors.teal[400],
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new UpdateOfficePage(
                                onSignedOut: widget.onSignedOut,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonTheme(
                      minWidth: 150.0,
                      height: 150.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                                color: Colors.teal[400], width: 2.5)),
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Update Staff Campus",
                                    style: GoogleFonts.roboto(
                                      color: Colors.teal[400],
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_city,
                                    color: Colors.teal[400],
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new UpdateCampusPage(
                                onSignedOut: widget.onSignedOut,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonTheme(
                      minWidth: 150.0,
                      height: 150.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                                color: Colors.teal[400], width: 2.5)),
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Update Staff Role",
                                    style: GoogleFonts.roboto(
                                      color: Colors.teal[400],
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_city,
                                    color: Colors.teal[400],
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new UpdateRolePage(
                                onSignedOut: widget.onSignedOut,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonTheme(
                      minWidth: 150.0,
                      height: 150.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                                color: Colors.teal[400], width: 2.5)),
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Add Staff",
                                    style: GoogleFonts.roboto(
                                      color: Colors.teal[400],
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.face,
                                    color: Colors.teal[400],
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new AddStaffPage(
                                onSignedOut: widget.onSignedOut,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
