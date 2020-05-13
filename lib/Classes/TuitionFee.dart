import 'package:cloud_firestore/cloud_firestore.dart';

class TuitionFee {
  double _tuitionrate;

  setTuitionFees(double _tuitionrate, String _major) {
    Firestore.instance
        .collection('/TuitionFee')
        .add({'Major': _major, 'TuitionRate': _tuitionrate});
  }

  Future<double> computeTuitionFee(int _numberofcredits, String _major) async {
    await Firestore.instance
        .collection('/TuitionFee')
        .where('Major', isEqualTo: _major)
        .getDocuments()
        .then((doc) {
      _tuitionrate = doc.documents[0].data['TuitionRate'];
    });
    return _numberofcredits * _tuitionrate;
  }

  //payTuitionFee(){ }

  //requestStatementOfFees(double _tuitionfee)

  updateTuitionFeeRates(double _tuitionrate, String _major)async{
   await Firestore.instance
        .collection('/TuitionFee')
        .where('Major', isEqualTo: _major)
        .getDocuments()
         .then((doc) {
      Firestore.instance
          .document('/TuitionFee/${doc.documents[0].documentID}')
          .updateData({'TuitionRate': _tuitionrate});
    });

  }
}
