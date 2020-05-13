import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_management_system/Classes/Constants.dart';
import 'package:university_management_system/Classes/Petition.dart';

class PetitionPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final String uid;
  PetitionPage({this.onSignedOut, @required this.uid});
  @override
  _PetitionPageState createState() => new _PetitionPageState();
}

class _PetitionPageState extends State<PetitionPage> {
  void signOut(BuildContext context) async {
    try {
      Navigator.pop(context);
      await FirebaseAuth.instance.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void _choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      signOut(context);
    }
  }

  Icon _setIcon(String status) {
    Icon icon;
    if (status == 'Pending') {
      icon = Icon(
        Icons.schedule,
        color: Colors.white,
        size: 40.0,
      );
    } else if (status == 'Accepted') {
      icon = Icon(
        Icons.check,
        color: Colors.greenAccent,
        size: 40.0,
      );
    } else if (status == 'Rejected') {
      icon = Icon(
        Icons.close,
        color: Colors.red,
        size: 40.0,
      );
    }
    return icon;
  }

  void _petitionSheet() {
    
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Petitions"),
        backgroundColor: Colors.teal[400],
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _choiceAction,
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
      body: new StreamBuilder<QuerySnapshot>(
          stream: Petition().getUserPetition(widget.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null)
              return new Center(
                child: new CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.teal[400]),
                ),
              );

            var items = snapshot.data.documents;

            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.teal[400],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                '${items[index].data['PetitionTitle']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'Type: ${items[index].data['PetitionType']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          _setIcon(items[index]
                                              .data['PetitionStatus']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _petitionSheet,
        label: Text('New Petition'),
        icon: Icon(Icons.create),
        backgroundColor: Colors.lightBlueAccent,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      ),
    );
  }
}
