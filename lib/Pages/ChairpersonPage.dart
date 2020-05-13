import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university_management_system/Classes/Constants.dart';
import 'package:university_management_system/Classes/Staff.dart';
import 'package:university_management_system/Pages/CoursePage.dart';

class ChairpersonPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final Staff staff;
  ChairpersonPage({this.onSignedOut, this.staff});
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
        padding: const EdgeInsets.all(30.0),
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
                                  "Courses",
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
                                Icons.library_books,
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
                            builder: (context) => new CoursePage(
                              onSignedOut: widget.onSignedOut,
                              type: "Chairperson",
                              staff: widget.staff,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ButtonTheme(
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
                                  children: <Widget>[
                                    Text(
                                      "Petitions",
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
                                  children: <Widget>[
                                    Icon(
                                      Icons.gavel,
                                      color: Colors.teal[400],
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ButtonTheme(
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
                                  children: <Widget>[
                                    Text(
                                      "Facility",
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
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 150.0,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(
                                  color: Colors.teal[400], width: 2.5)),
                          child: Column(children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Teams",
                                    style: GoogleFonts.roboto(
                                      color: Colors.teal[400],
                                      fontSize: 26.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Row(children: <Widget>[
                                Icon(
                                  Icons.group,
                                  size: 30,
                                  color: Colors.teal[400],
                                )
                              ]),
                            ),
                          ]),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 150.0,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(
                                  color: Colors.teal[400], width: 2.5)),
                          child: Column(children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Clubs",
                                    style: GoogleFonts.roboto(
                                      color: Colors.teal[400],
                                      fontSize: 26.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Row(children: <Widget>[
                                Icon(
                                  Icons.category,
                                  size: 30,
                                  color: Colors.teal[400],
                                )
                              ]),
                            ),
                          ]),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
      ))),
    );
  }
}
