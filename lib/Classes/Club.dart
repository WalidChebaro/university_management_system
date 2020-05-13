import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class Club {
  var randnb = Random(25);
  // requestClub(){

  // }
  createClub(String _clubname, String _clubdescription, String _firstName,
      String _lastname) {
    String _clubpresident = "$_firstName $_lastname";
    Firestore.instance.collection('/Club').add({
      'ClubName': _clubname,
      'ClubDescription': _clubdescription,
      'ClubLeader': _clubpresident,
    });
  }

  joinClub(String _clubname, String _firstname, String _lastname, int _id) {
    Firestore.instance
        .collection('/Club')
        .where('ClubName', isEqualTo: _clubname)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .collection('/ClubMembers')
          .add({'FirstName': _firstname, 'LastName': _lastname, 'ID': _id});
    });
  }

  createNewPost(String _clubname, String _posttitle, String _postinformation) {
    Firestore.instance
        .collection('/Club')
        .where('ClubName', isEqualTo: _clubname)
        .getDocuments()
        .then((doc) {
      Firestore.instance.collection('/Post').add({
        'PostTitle': _posttitle,
        'PostInformation': _postinformation,
      });
    });
  }

  Stream<QuerySnapshot> getPostFeed(String _clubname) {
    Stream<QuerySnapshot> file;
    Firestore.instance
        .collection('/Club')
        .where('ClubName', isEqualTo: _clubname)
        .getDocuments()
        .then((doc) {
      file = Firestore.instance.collection('/Post').getDocuments().asStream();
    });
    return file;
  }

  Stream<QuerySnapshot> getClubDescription(int _id) {
    return Firestore.instance
        .collection('/Club')
        .where('ClubMember/ID', isEqualTo: _id)
        .getDocuments()
        .asStream();
  }

  Stream<QuerySnapshot> getClubMembers(String _clubname) {
    Stream<QuerySnapshot> file;
    Firestore.instance
        .collection('/Club')
        .where('ClubName', isEqualTo: _clubname)
        .getDocuments()
        .then((doc) {
      file = Firestore.instance
          .collection('/ClubMember')
          .getDocuments()
          .asStream();
    });
    return file;
  }

  Stream<QuerySnapshot> getClubFiles(String _clubname) {
    Stream<QuerySnapshot> file;
    Firestore.instance
        .collection('/Club')
        .where('ClubName', isEqualTo: _clubname)
        .getDocuments()
        .then((doc) {
      file =
          Firestore.instance.collection('/ClubFiles').getDocuments().asStream();
    });
    return file;
  }

  uploadFileToClub(var file) async {
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilepics/${randnb.nextInt(5000).toString()}.jpg');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    dowurl.toString();
  }
}
