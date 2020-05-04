import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:university_management_system/TestPage.dart';

import 'User.dart';
import 'TeacherPage.dart';

class Staff {
  int _id;
  String _uid;
  String _dateofbirth;
  String _firstname;
  String _lastname;
  String _role;
  String _campus;
  String _address;
  String _office;
  int _phone;

 Future<String> setAttributeValues() async {
    await User().getUserInfo().then((doc) {
      _id = doc.documents[0].data['ID'];
      _firstname = doc.documents[0].data['FirstName'];
      _lastname = doc.documents[0].data['LastName'];
      _role = doc.documents[0].data['Role'];
      _dateofbirth = doc.documents[0].data['DateOfBirth'];
      _address = doc.documents[0].data['Address'];
      _phone = doc.documents[0].data['Phone'];
      _campus = doc.documents[0].data['Campus'];
      _office = doc.documents[0].data['Office'];
    });
    return _role;
  }

//Getters
  int get id => _id;
  String get uid => _uid;
  String get dateofbirth => _dateofbirth;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get role => _role;
  String get campus => _campus;
  String get address => _address;
  String get office => _office;
  int get phone => _phone;

}
