import 'package:cloud_firestore/cloud_firestore.dart';

class ScholarShip {
  applyForScholarship(
      int _id,
      String _uid,
      String _firstname,
      String _lastname,
      String _scholarshipinformation,
      String _scholarshipstatus,
      String _scholarshipapplicationstatus) {
    Firestore.instance.collection('/ScholarShip').add({
      'ID': _id,
      'uid': _uid,
      'FirstName': _firstname,
      'LastName': _lastname,
      'ScholarShipInformation': _scholarshipinformation,
      'ScholarShipApplicationStatus': "Pending",
      'ScholarShipStatus': "Pending",
    });
  }

  Stream<QuerySnapshot> retrieveScholarShipApplications() {
    return Firestore.instance
        .collection('/ScholarShip')
        .getDocuments()
        .asStream();
  }

  Future updateScholarShipStatus(String _scholarshipstatus, int _id) async {
    await Firestore.instance
        .collection('/ScholarShip')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/ScholarShip/${doc.documents[0].documentID}')
          .updateData({'ScholarShipStatus': _scholarshipstatus});
    });
  }

  Future updateScholarshipApplicationStatus(
      String _scholarshipapplicationstatus, int _id) async {
    await Firestore.instance
        .collection('/ScholarShip')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/ScholarShip/${doc.documents[0].documentID}')
          .updateData(
              {'ScholarShipApplicationStatus': _scholarshipapplicationstatus});
    });
  }

    Stream<QuerySnapshot> getScholarshipInformation(String _id) {
    return Firestore.instance
        .collection('/ScholarShip')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .asStream();
  }
  
}
