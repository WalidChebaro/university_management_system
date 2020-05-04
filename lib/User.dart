import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class User {
  String _email;
  DocumentSnapshot snapshot;
  String info;
  int _incrementId;

  createNewStaffUser(_email, _password, _firstname, _lastname, _dateofbirth,
      _address, _phone, _type, _role, _campus, _office) async {
    try {
      Firestore.instance
          .collection('/currentid')
          .getDocuments()
          .then((doc) async {
        snapshot = await Firestore.instance
            .document('/currentid/${doc.documents[0].documentID}')
            .get();
        _incrementId = snapshot.data['incrementedid'];
      });

      if (_incrementId / 100000 < DateTime.now().year) {
        _incrementId = DateTime.now().year * 100000;
      } else {}
      _incrementId += 1;

      Firestore.instance.collection('/currentid').getDocuments().then((doc) {
        Firestore.instance
            .document('/currentid/${doc.documents[0].documentID}')
            .updateData({'incrementedid': _incrementId}).then((val) {
          print('updated');
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {});
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((AuthResult auth) {
        FirebaseAuth.instance.currentUser().then((user) {
          Firestore.instance.collection('/User').add({
            'uid': user.uid,
            'ID': _incrementId,
            'FirstName': _firstname,
            'LastName': _lastname,
            'DateOfBirth': _dateofbirth,
            'Address': _address,
            'Phone': _phone,
            'Type': _type,
            'Role': _role,
            'Campus': _campus,
            'Office': _office,
          }).catchError((e) {
            print(e);
          });
        }).catchError((e) {
          print(e);
        });
      });
    } catch (e) {}
  }

  createNewStudentUser(_email, _password, _firstname, _lastname, _dateofbirth,
      _address, _phone, _type, _campus, _major) async {
    try {
      Firestore.instance
          .collection('/currentid')
          .getDocuments()
          .then((doc) async {
        snapshot = await Firestore.instance
            .document('/currentid/${doc.documents[0].documentID}')
            .get();
        _incrementId = snapshot.data['incrementedid'];
      });

      if (_incrementId / 100000 < DateTime.now().year) {
        _incrementId = DateTime.now().year * 100000;
      } else {}
      _incrementId += 1;

      Firestore.instance.collection('/currentid').getDocuments().then((doc) {
        Firestore.instance
            .document('/currentid/${doc.documents[0].documentID}')
            .updateData({'incrementedid': _incrementId}).then((val) {
          print('updated');
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {});

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((AuthResult auth) {
        FirebaseAuth.instance.currentUser().then((user) {
          Firestore.instance.collection('/User').add({
            'uid': user.uid,
            'ID': _incrementId,
            'FirstName': _firstname,
            'LastName': _lastname,
            'DateOfBirth': _dateofbirth,
            'Address': _address,
            'Phone': _phone,
            'Type': _type,
            'Campus': _campus,
            'Major': _major,
          }).catchError((e) {
            print(e);
          });
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {});
    } catch (e) {}
  }

  getEmail() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _email = user.email;
    return _email;
  }

  updateUserPassword(_password) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user.updatePassword(_password);
  }

  Future<String> userType() async {
    String result;
    await FirebaseAuth.instance.currentUser().then((user) async {
      await Firestore.instance
          .collection('/User')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((doc) {
        result = doc.documents[0].data['Type'];
      });
    });
    return result;
  }

  Future getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await  Firestore.instance
        .collection('/User')
        .where('uid', isEqualTo: user.uid)
        .getDocuments();
  }

  Future updateMajor(_major, _id) async {
    Firestore.instance
        .collection('/User')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/User/${doc.documents[0].documentID}')
          .updateData({'Major': _major}).then((val) {
        print('updated');
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future updateCampus(_campus, _id) async {
    Firestore.instance
        .collection('/User')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/User/${doc.documents[0].documentID}')
          .updateData({'Campus': _campus}).then((val) {
        print('updated');
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {});
  }

  Future updateOffice(_office, _id) async {
    Firestore.instance
        .collection('/User')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/User/${doc.documents[0].documentID}')
          .updateData({'Office': _office}).then((val) {
        print('updated');
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {});
  }

  Future updateRole(_role, _id) async {
    Firestore.instance
        .collection('/User')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/User/${doc.documents[0].documentID}')
          .updateData({'Role': _role}).then((val) {
        print('updated');
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {});
  }

  Future updatePhone(_phone) async {
    await FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/User')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((doc) {
        Firestore.instance
            .document('/User/${doc.documents[0].documentID}')
            .updateData({'Phone': _phone}).then((val) {
          print('updated');
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {});
    }).catchError((e) {});
  }

  Future updateAddress(_address) async {
    await FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/User')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((doc) {
        Firestore.instance
            .document('/User/${doc.documents[0].documentID}')
            .updateData({'Address': _address}).then((val) {
          print('updated');
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {});
    }).catchError((e) {});
  }
}
