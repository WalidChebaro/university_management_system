import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university_management_system/Classes/Constants.dart';
import 'package:university_management_system/Classes/Staff.dart';
import 'package:university_management_system/Pages/ManageStudentsPage.dart';
import 'package:university_management_system/Pages/ManageStaffPage.dart';
import 'package:university_management_system/Pages/PetitionPage.dart';

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

  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String _firstname = widget.staff.firstname;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Portal"),
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
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(children: <Widget>[
                    Text(
                      'Hello, ', // replace by $_currentuser
                      style: GoogleFonts.roboto(
                          fontSize: 26.0,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  Column(children: <Widget>[
                    Text(
                      '$_firstname', // replace by $_currentuser
                      style: GoogleFonts.roboto(
                        fontSize: 26.0,
                        color: Colors.teal,
                      ),
                    ),
                  ]),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      color: Colors.teal[400],
                      child: new Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Manage Students",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(children: <Widget>[
                              Icon(
                                Icons.school,
                                size: 50,
                                color: Colors.white,
                              )
                            ]),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => new ManageStudentsPage(
                              onSignedOut: widget.onSignedOut,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      color: Colors.teal[400],
                      child: new Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Manage Staff",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(children: <Widget>[
                              Icon(
                                Icons.face,
                                size: 50,
                                color: Colors.white,
                              )
                            ]),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => new ManageStaffPage(
                              onSignedOut: widget.onSignedOut,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      color: Colors.teal[400],
                      child: new Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Manage Petitions",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(children: <Widget>[
                              Icon(
                                Icons.gavel,
                                size: 50,
                                color: Colors.white,
                              )
                            ]),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => new PetitionPage(
                              onSignedOut: widget.onSignedOut,
                              type: "Registrar",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ]),
      ))),
    );
  }
}

class ManageStudentsStaff {}
