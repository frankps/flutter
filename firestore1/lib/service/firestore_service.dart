import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/model/basemodel.dart';


class FirestoreService<T extends BaseModel> {

  String _firestorePath;

  CollectionReference _objectCollection;

  FirestoreService(this._firestorePath) {
    this._objectCollection = Firestore.instance.collection(this._firestorePath);
  }

  Future<dynamic> createObject(T obj) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(_objectCollection.document());

      obj.id = ds.documentID;

      final Map<String, dynamic> data = obj.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      var objNew = obj.createNew();   

      return objNew.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = _objectCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateObject(T note) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(_objectCollection.document(note.id));

      await tx.update(ds.reference, note.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteObject(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(_objectCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
