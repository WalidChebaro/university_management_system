import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_management_system/Classes/Constants.dart';
import 'package:university_management_system/Classes/Petition.dart';

class PetitionPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final String uid;
  final String type;
  PetitionPage({this.onSignedOut, this.uid, this.type});
  @override
  _PetitionPageState createState() => new _PetitionPageState();
}

class _PetitionPageState extends State<PetitionPage> {
  var stream;
  Stream<QuerySnapshot> newStream() => Petition().retrievePetitionsByStatus();
  @override
  void initState() {
    super.initState();
    stream = newStream(); // initial stream
  }

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

  void _petitionSheet() {}

  Future<void> _petitionInformation(
    String _petitiontitle,
    String _petitioncontent,
    String _firstname,
    String _lastname,
    int _id,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$_petitiontitle'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$_firstname'),
                Text('$_lastname'),
                Text('$_id'),
                Text(''),
                Text('Petition Information:'),
                Text('$_petitioncontent'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve', style: TextStyle(color: Colors.teal),),
              onPressed: () {
                Navigator.of(context).pop();
                Petition()
                    .updatePetitionStatus(_petitiontitle, _id, "Approved")
                    .then((val) {
                  setState(() {
                    stream = newStream(); //refresh/reset the stream
                  });
                });
              },
            ),
            FlatButton(
              child: Text('Reject', style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
                Petition()
                    .updatePetitionStatus(_petitiontitle, _id, "Rejected")
                    .then((val) {
                  setState(() {
                    stream = newStream(); //refresh/reset the stream
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _petitiontitle;
    String _petitioncontent;
    String _firstname;
    String _lastname;
    int _id;
    if (widget.type == "Student") {
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
            stream: stream,
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
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
        ),
      );
    } else if (widget.type == "Registrar") {
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
            stream: Petition().retrievePetitionsByStatus(),
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
                    _petitioncontent = items[index].data['PetitionContent'];
                    _firstname = items[index].data['FirstName'];
                    _lastname = items[index].data['LastName'];
                    _id = items[index].data['ID'];
                    _petitiontitle = items[index].data['PetitionTitle'];
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
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(15)),
                                    color: Colors.teal[400],
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
                                                  '$_petitiontitle',
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
                                      ],
                                    ),
                                    onPressed: () {
                                      _petitionInformation(
                                        _petitiontitle,
                                        _petitioncontent,
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
                    );
                  });
            }),
      );
    }

    return null;
  }
}
