import 'package:cloud_firestore/cloud_firestore.dart';

class Petition {
  //if title and uid are matched in firestore request user to change title
  applyPetition(int _id, String _uid, String _firstname, String _lastname,
      String _petitiontitle, String _petitiontype, String _petitioncontent) {
    Firestore.instance.collection('/Petition').add({
      'ID': _id,
      'uid': _uid,
      'FirstName': _firstname,
      'LastName': _lastname,
      'PetitionTitle': _petitiontitle,
      'PetitionType': _petitiontype,
      'PetitionContent': _petitioncontent,
      'PetitionStatus': "Pending"
    });
  }

  Stream<QuerySnapshot> retrievePetitionsByStatus() {
    return Firestore.instance
        .collection('/Petition')
        .where('PetitionStatus', isEqualTo: "Pending")
        .getDocuments()
        .asStream();
  }

  Future updatePetitionStatus(
      String _petitiontitle, int _id, String _petitionstatus) async {
    await Firestore.instance
        .collection('/Petition')
        .where('PetitionTitle', isEqualTo: _petitiontitle)
        .where('ID', isEqualTo: _id)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .document('/Petition/${doc.documents[0].documentID}')
          .updateData({'PetitionStatus': _petitionstatus});
    });
  }

  Stream<QuerySnapshot> getUserPetition(String _uid) {
    return Firestore.instance
        .collection('/Petition')
        .where('uid', isEqualTo: _uid)
        .getDocuments()
        .asStream();
  }
}
