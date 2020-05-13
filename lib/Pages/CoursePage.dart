import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university_management_system/Classes/Constants.dart';
import 'package:university_management_system/Classes/Course.dart';
import 'package:university_management_system/Classes/Staff.dart';
import 'package:university_management_system/Classes/Student.dart';

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

class CoursePage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final String type;
  final Student student;
  final Staff staff;

  CoursePage({
    this.onSignedOut,
    this.type,
    this.student,
    this.staff,
  });
  @override
  _CoursePageState createState() => new _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
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
    int _coursesection;
    String _coursename;
    String _courseinformation;
    int _coursecredithours;
    String _firstname;
    String _lastname;
    int _id;
    if (widget.type == "Student") {
      return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text("Courses"),
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
        // body: new StreamBuilder<QuerySnapshot>(
        //     stream: Course().getCoursesStudent(widget.student.uid),
        //     builder:
        //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //       if (snapshot.data == null)
        //         return new Center(
        //           child: new CircularProgressIndicator(
        //             valueColor:
        //                 new AlwaysStoppedAnimation<Color>(Colors.teal[400]),
        //           ),
        //         );

        //       var items = snapshot.data.documents;

        //       return ListView.builder(
        //           itemCount: items.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             return SafeArea(
        //               child: Padding(
        //                 padding:
        //                     const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: <Widget>[
        //                     Row(
        //                       children: <Widget>[
        //                         Expanded(
        //                           child: Container(
        //                             decoration: BoxDecoration(
        //                               color: Colors.teal[400],
        //                               borderRadius: BorderRadius.circular(15),
        //                             ),
        //                             padding: EdgeInsets.all(20),
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: <Widget>[
        //                                 Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: <Widget>[
        //                                     Row(
        //                                       children: <Widget>[
        //                                         Text(
        //                                           '${items[index].data['CourseName']}',
        //                                           style: TextStyle(
        //                                               color: Colors.white,
        //                                               fontSize: 25.0),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                     Row(
        //                                       children: <Widget>[
        //                                         Text(
        //                                           'Type: ${items[index].data['CourseSection']}',
        //                                           style: TextStyle(
        //                                               color: Colors.white,
        //                                               fontSize: 15.0),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             );
        //           });
        //     }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('Manage Courses'),
          icon: Icon(Icons.create),
          backgroundColor: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
        ),
      );
    } else if (widget.type == "Teacher") {
      return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text("Courses"),
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
    } else if (widget.type == "Chairperson") {
      return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text("Courses"),
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
          body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new TextField(
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Teacher First Name"),
                          onChanged: (value) {
                            setState(() {
                              _firstname = value;
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
                              hintText: "Teacher Last Name"),
                          onChanged: (value) {
                            setState(() {
                              _lastname = value;
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
                              hintText: "Teacher ID"),
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
                              hintText: "Course Name"),
                          onChanged: (value) {
                            setState(() {
                              _coursename = value;
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Credit Hours"),
                          onChanged: (value) {
                            setState(() {
                              _coursecredithours = int.parse(value);
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Course Section"),
                          onChanged: (value) {
                            setState(() {
                              _coursesection = int.parse(value);
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
                              hintText: "Course Description"),
                          onChanged: (value) {
                            setState(() {
                              _courseinformation = value;
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
                          child: Text('Create course'),
                          color: Colors.lightBlue,
                          textColor: Colors.white,
                          elevation: 10.0,
                          onPressed: () {
                            Course().addSection(
                              _coursesection,
                              _coursename,
                              _courseinformation,
                              _coursecredithours,
                              _firstname,
                              _lastname,
                              _id,
                            );
                          },
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
    return null;
  }
}
