import 'package:cloud_firestore/cloud_firestore.dart';

class FinancialAid {
  applyForFinancialAid(
      int _id,
      String _uid,
      String _firstname,
      String _lastname,
      String _financialaidinformation,
      String _financialaidstatus,
      String _financialaidapplicationstatus) {
    Firestore.instance.collection('/FinancialAid').add({
      'ID': _id,
      'uid': _uid,
      'FirstName': _firstname,
      'LastName': _lastname,
      'FinancialAidInformation': _financialaidinformation,
      'FinancialAidStatus': "Pending",
      'FinancialAidApplicationStatus': "Pending",
    });
  }

  Stream<QuerySnapshot> retrieveFinancialAidApplications() {
    return Firestore.instance
        .collection('/FinancialAid')
        .getDocuments()
        .asStream();
  }

  Future updateFinancialAidStatus(String _financialaidstatus, int _id) async {
    await Firestore.instance
        .collection('/FinancialAid')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/FinancialAid/${doc.documents[0].documentID}')
          .updateData({'FinancialAidStatus': _financialaidstatus});
    });
  }

  Future updateFinancialAidApplicationStatus(
      String _financialaidapplicationstatus, int _id) async {
    await Firestore.instance
        .collection('/FinancialAid')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/FinancialAid/${doc.documents[0].documentID}')
          .updateData({
        'FinancialAidApplicationStatus': _financialaidapplicationstatus
      });
    });
  }

  Stream<QuerySnapshot> getFinancialAidformation(String _id) {
    return Firestore.instance
        .collection('/FinancialAid')
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .asStream();
  }
}
