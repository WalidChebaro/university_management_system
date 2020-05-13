import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory {
  addToInventory(String _itemname, int _numberofitem, String _iteminformation) {
    Firestore.instance.collection('/Inventory').add({
      'ItemName': _itemname,
      'NumberOfItem': _numberofitem,
      'ItemInformation': _iteminformation
    });
  }

  Stream<QuerySnapshot> getInventory() {
    return Firestore.instance
        .collection('/Inventory')
        .getDocuments()
        .asStream();
  }

  Future updateInventory(String _itemname, int _numberofitem) async {
    if (_numberofitem == 0) {
      await Firestore.instance
          .collection('/Inventory')
          .where('ItemName', isEqualTo: _itemname)
          .getDocuments()
          .then((doc) {
        Firestore.instance
            .document('/Inventory/${doc.documents[0].documentID}')
            .delete();
      });
    } else {
      await Firestore.instance
          .collection('/Inventory')
          .where('ItemName', isEqualTo: _itemname)
          .getDocuments()
          .then((doc) {
        Firestore.instance
            .document('/Inventory/${doc.documents[0].documentID}')
            .updateData({'NumberOfItem': _numberofitem});
      });
    }
  }

  Stream<QuerySnapshot> getItemInformation(String _itemname) {
    return Firestore.instance
        .collection('/Inventory')
        .where('ItemName', isEqualTo: _itemname)
        .getDocuments()
        .asStream();
  }
}
