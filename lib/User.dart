import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class User {
  DocumentSnapshot snapshot;
  String info;
  int _incrementId;
  String _email;
  String _password;
  int year = DateTime.now().year;
  int month = DateTime.now().month;

  Future createNewStaffUser(_firstname, _lastname, _dateofbirth, _address,
      _phone, _role, _campus, _office, _usernb) async {
    if (_usernb > 0) {
      _email = "$_firstname.$_lastname$_usernb@uni.edu";
    } else {
      _email = "$_firstname.$_lastname@uni.edu";
    }
    if (month > 8) {
      _password = "Fall$year";
    } else if (month < 6) {
      _password = "Spring$year";
    } else {
      _password = "Summer$year";
    }
    FirebaseApp app = await FirebaseApp.configure(
        name: 'Secondary', options: await FirebaseApp.instance.options);
    await FirebaseAuth.fromApp(app)
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((AuthResult auth) async {
          print("test");
      await Firestore.instance
          .collection('/currentid')
          .getDocuments()
          .then((doc) async {
        snapshot = await Firestore.instance
            .document('/currentid/${doc.documents[0].documentID}')
            .get();
        _incrementId = snapshot.data['incrementedid'];
      }).catchError((e) {
        print(e);
      });
      if (_incrementId / 100000 < year) {
        _incrementId = year * 100000;
      }
      _incrementId += 1;
      await FirebaseAuth.fromApp(app).currentUser().then((user) async {
        await Firestore.instance.collection('/User').add({
          'uid': user.uid,
          'ID': _incrementId,
          'FirstName': _firstname,
          'LastName': _lastname,
          'DateOfBirth': _dateofbirth,
          'Address': _address,
          'Phone': _phone,
          'Type': 'Staff',
          'Role': _role,
          'Campus': _campus,
          'Office': _office,
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
      await Firestore.instance
          .collection('/currentid')
          .getDocuments()
          .then((doc) async {
        await Firestore.instance
            .document('/currentid/${doc.documents[0].documentID}')
            .updateData({'incrementedid': _incrementId})
            .then((val) {})
            .catchError((e) {
              print(e);
            });
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          _usernb += 1;
          createNewStaffUser(_firstname, _lastname, _dateofbirth, _address,
              _phone, _role, _campus, _office, _usernb);
        } else {
          print(e);
        }
      }
    });
  }

  Future createNewStudentUser(_firstname, _lastname, _dateofbirth, _address,
      _phone, _campus, _major, _usernb) async {
    if (_usernb > 0) {
      _email = "$_firstname.$_lastname$_usernb@uni.edu";
    } else {
      _email = "$_firstname.$_lastname@uni.edu";
    }
    if (month > 8) {
      _password = "Fall$year";
    } else if (month < 6) {
      _password = "Spring$year";
    } else {
      _password = "Summer$year";
    }
    FirebaseApp app = await FirebaseApp.configure(
        name: 'Secondary', options: await FirebaseApp.instance.options);
    await FirebaseAuth.fromApp(app)
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((AuthResult auth) async {
      await Firestore.instance
          .collection('/currentid')
          .getDocuments()
          .then((doc) async {
        snapshot = await Firestore.instance
            .document('/currentid/${doc.documents[0].documentID}')
            .get();
        _incrementId = snapshot.data['incrementedid'];
      }).catchError((e) {
        print(e);
      });
      if (_incrementId / 100000 < year) {
        _incrementId = year * 100000;
      }
      _incrementId += 1;
      await FirebaseAuth.fromApp(app).currentUser().then((user) async {
        await Firestore.instance.collection('/User').add({
          'uid': user.uid,
          'ID': _incrementId,
          'FirstName': _firstname,
          'LastName': _lastname,
          'DateOfBirth': _dateofbirth,
          'Address': _address,
          'Phone': _phone,
          'Type': 'Student',
          'Campus': _campus,
          'Major': _major,
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
      await Firestore.instance
          .collection('/currentid')
          .getDocuments()
          .then((doc) async {
        await Firestore.instance
            .document('/currentid/${doc.documents[0].documentID}')
            .updateData({'incrementedid': _incrementId})
            .then((val) {})
            .catchError((e) {
              print(e);
            });
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          _usernb += 1;
          createNewStudentUser(_firstname, _lastname, _dateofbirth, _address,
              _phone, _campus, _major, _usernb);
        } else {
          print(e);
        }
      }
    });
  }

  Future<String> getEmail() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _email = user.email;
    return _email;
  }

  Future updateUserPassword(_password) async {
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

  Future<QuerySnapshot> getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
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
