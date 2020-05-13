import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class Team {
  var randnb = Random(25);
  createTeam(String _teamname, String _teamdescription, String _firstName,
      String _lastname) {
    String _teamleader = "$_firstName $_lastname";
    Firestore.instance.collection('/Team').add({
      'TeamName': _teamname,
      'TeamDescription': _teamdescription,
      'TeamLeader': _teamleader,
    });
  }

  joinTeam(String _teamname, String _firstname, String _lastname, int _id) {
    Firestore.instance
        .collection('/Team')
        .where('TeamName', isEqualTo: _teamname)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .collection('/TeamMembers')
          .add({'FirstName': _firstname, 'LastName': _lastname, 'ID': _id});
    });
  }

  createNewTask(String _teamname, String _tasktitle, String _taskinformation) {
    Firestore.instance
        .collection('/Team')
        .where('TeamName', isEqualTo: _teamname)
        .getDocuments()
        .then((doc) {
      Firestore.instance.collection('/Task').add({
        'TaskTitle': _tasktitle,
        'TaskInformation': _taskinformation,
      });
    });
  }

  Stream<QuerySnapshot> getTasksFeed(String _teamname) {
    Stream<QuerySnapshot> file;
    Firestore.instance
        .collection('/Team')
        .where('TeamName', isEqualTo: _teamname)
        .getDocuments()
        .then((doc) {
      file = Firestore.instance.collection('/Task').getDocuments().asStream();
    });
    return file;
  }

  Stream<QuerySnapshot> getTeamInformation(int _id) {
    return Firestore.instance
        .collection('/Team')
        .where('TeamMember/ID', isEqualTo: _id)
        .getDocuments()
        .asStream();
  }

  Stream<QuerySnapshot> getTeamMembers(String _teamname) {
    Stream<QuerySnapshot> file;
    Firestore.instance
        .collection('/Team')
        .where('TeamName', isEqualTo: _teamname)
        .getDocuments()
        .then((doc) {
      file = Firestore.instance
          .collection('/TeamMember')
          .getDocuments()
          .asStream();
    });
    return file;
  }

  Stream<QuerySnapshot> getTeamFiles(String _teamname) {
    Stream<QuerySnapshot> file;
    Firestore.instance
        .collection('/Team')
        .where('TeamName', isEqualTo: _teamname)
        .getDocuments()
        .then((doc) {
      file =
          Firestore.instance.collection('/TeamFiles').getDocuments().asStream();
    });
    return file;
  }

  uploadFileToTeam(var file) async {
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilepics/${randnb.nextInt(5000).toString()}.jpg');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    dowurl.toString();
  }
}
