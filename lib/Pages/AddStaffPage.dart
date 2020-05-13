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

class AddStaffPage extends StatefulWidget {
  final VoidCallback onSignedOut;
  AddStaffPage({this.onSignedOut});
  @override
  _AddStaffPageState createState() => new _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  String _firstname;
  String _lastname;
  String _address;
  String _campus;
  int _phone;
  String _dateofbirth;
  String _office;
  String _role;

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
                          hintText: "Date of Birth"),
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
                          kTextFieldDecoration.copyWith(hintText: "Office"),
                      onChanged: (value) {
                        setState(() {
                          _office = value;
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
                    child: new TextField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: "Role"),
                      onChanged: (value) {
                        setState(() {
                          _role = value;
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
                      child: Text('create staff account'),
                      color: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      elevation: 10.0,
                      onPressed: () {
                        User().createNewStaffUser(
                            _firstname,
                            _lastname,
                            _dateofbirth,
                            _address,
                            _phone,
                            _role,
                            _campus,
                            _office,
                            0);
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
