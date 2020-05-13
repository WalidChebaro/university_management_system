import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class AddStudentPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  AddStudentPage({this.onSignedOut});
  @override
  _AddStudentPageState createState() => new _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  String _firstname;
  String _lastname;
  String _address;
  String _campus;
  String _major;
  int _phone;
  String _dateofbirth;

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
        title: Text("Manage Student"),
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
          padding: const EdgeInsets.all(20.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new TextField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: "First Name"),
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
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: "Last Name"),
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
                          hintText: "Date of birth"),
                      onChanged: (value) {
                        setState(() {
                          _dateofbirth = (value);
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
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: "Campus"),
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
                    child: new TextField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: "Major"),
                      onChanged: (value) {
                        setState(() {
                          _major = value;
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
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: "Phone"),
                      onChanged: (value) {
                        setState(() {
                          _phone = int.parse(value);
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
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: "Address"),
                      onChanged: (value) {
                        setState(() {
                          _address = value;
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
                      child: Text('Create student account'),
                      color: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      elevation: 10.0,
                      onPressed: () {
                        User().createNewStudentUser(_firstname, _lastname,
                            _dateofbirth, _address, _phone, _campus, _major, 0);
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
}
