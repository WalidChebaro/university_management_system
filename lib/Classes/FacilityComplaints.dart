import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class FacilityComplaint {
  var randnb = Random(25);

  submitComplaint(String _uid, String _complainttitle, String _complainttype,
      String _complaintinformation, var file) async {
    String _url;
    if (file != null) {
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('profilepics/${randnb.nextInt(5000).toString()}.png');
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);

      var _dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      _url = _dowurl.toString();
    }
    Firestore.instance.collection('/FacilityComplaint').add({
      'uid': _uid,
      'complaintTitle': _complainttitle,
      'complaintType': _complainttype,
      'complaintInformation': _complaintinformation,
      'complaintpictureurl': _url,
      'complaintStatus': "Pending",
    });
  }
}

Stream<QuerySnapshot> retrieveComplaintsByType(String _complainttype) {
  return Firestore.instance
      .collection('/FacilityComplaint')
      .where('ComplaintType', isEqualTo: _complainttype)
      .getDocuments()
      .asStream();
}

Future updateComplaintStatus(
    String _complainttitle, int _id, String _complaintstatus) async {
  await Firestore.instance
      .collection('/FacilityComplaint')
      .where('ComplaintTitle', isEqualTo: _complainttitle)
      .getDocuments()
      .then((doc) {
    Firestore.instance
        .document('/FacilityComplaint/${doc.documents[0].documentID}')
        .updateData({'ComplaintStatus': _complaintstatus});
  });
}

Stream<QuerySnapshot> getUserComplaints(String _uid) {
  return Firestore.instance
      .collection('/FacilityComplaint')
      .where('uid', isEqualTo: _uid)
      .getDocuments()
      .asStream();
}
