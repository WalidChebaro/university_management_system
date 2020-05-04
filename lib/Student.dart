import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';

class Student {
  int _id;
  String _uid;
  DateTime _dateofbirth;
  String _firstname;
  String _lastname;
  String _campus;
  String _address;
  String _major;
  int _phone;

  //Student(this._id, this._uid, this._dateofbirth, this._firstname,
  //   this._lastname, this._campus, this._address, this._major, this._phone);

  // setAttributeValues() {
  //   _id = User().getUserInfo('ID');
  //   _firstname = User().getUserInfo('FirstName');
  //   _lastname = User().getUserInfo('LastName');
  //   _dateofbirth = User().getUserInfo('DateOfBirth');
  //   _address = User().getUserInfo('Address');
  //   _campus = User().getUserInfo('Campus');
  //   _major = User().getUserInfo('Major');
  //   _phone = User().getUserInfo('Phone');
  // }
//Getters
  int get id => _id;
  String get uid => _uid;
  DateTime get dateofbirth => _dateofbirth;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get campus => _campus;
  String get address => _address;
  String get major => _major;
  int get phone => _phone;
}
