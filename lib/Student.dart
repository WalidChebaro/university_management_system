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

  Future setAttributeValues() async {
    await User().getUserInfo().then((doc) {
      _id = doc.documents[0].data['ID'];
      _uid = doc.documents[0].data['uid'];
      _firstname = doc.documents[0].data['FirstName'];
      _lastname = doc.documents[0].data['LastName'];
      _dateofbirth = DateTime.parse(doc.documents[0].data['DateOfBirth'].toString());
      _address = doc.documents[0].data['Address'];
      _phone = doc.documents[0].data['Phone'];
      _campus = doc.documents[0].data['Campus'];
      _major = doc.documents[0].data['Major'];
    });
  }

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
