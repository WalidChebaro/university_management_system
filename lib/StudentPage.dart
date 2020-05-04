import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_management_system/Petition.dart';
import 'Student.dart';

class StudentPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  StudentPage({this.onSignedOut});
  @override
  _StudentPageState createState() => new _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String _petitiontitle;
  String _petitiontype;
  String _petitioncontent;
  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Student student = new Student();
  @override
  void initState() {
    super.initState();
    student.setAttributeValues().then((val) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Student Page'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              signOut(context);
            }),
      ),
      body: new Scaffold(
        body: new Container(
            child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: 'petitiontitle',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _petitiontitle = value;
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
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: 'petitiontype',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _petitiontype = value;
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
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: 'petitioncontent',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _petitioncontent = value;
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
                    child: Text('apply petition'),
                    color: Colors.green,
                    textColor: Colors.black,
                    elevation: 10.0,
                    onPressed: () {
                      Petition().applyPetition(
                          student.id,
                          student.uid,
                          student.firstname,
                          student.lastname,
                          _petitiontitle,
                          _petitiontype,
                          _petitioncontent);
                    },
                  ),
                ),
              ],
            ),
           
          ],
        )),
      ),
    );
  }
}


 // child: new StreamBuilder<QuerySnapshot>(
            //     stream: Petition().retrievePetitionsByType("qwewq"),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<QuerySnapshot> snapshot) {
            //       var items = snapshot.data.documents;
            //       return ListView.builder(
            //         itemCount: items.length,
            //         itemBuilder: (context, index) {
            //           return Text(items[index].data['PetitionContent']);
            //         },
            //       );
            //     }),