import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';

class Filter {
  final String field;
  final dynamic isEqualTo;
  final dynamic isLessThan;
  final dynamic isLessThanOrEqualTo;
  final dynamic isGreaterThan;
  final dynamic isGreaterThanOrEqualTo;
  final dynamic arrayContains;
  final List<dynamic> arrayContainsAny;
  final List<dynamic> whereIn;
  final bool isNull;
  Filter(
    this.field, {
    this.isEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.isNull,
  });
}

class FireStoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String collectionName;
  CollectionReference collection;
  FireStoreService({this.collectionName}) {
    String namespace = Flavor.I.getString("namespace");
    this.collectionName = "$namespace$collectionName";
    this.collection = db.collection(collectionName);
  }

  Future<List> findAll({
    List<Filter> filters,
    String orderBy = '',
    bool orderDescending = true,
    Source source = Source.serverAndCache,
  }) async {
    // try {

    Query query = collection;
    QuerySnapshot result;
    if (filters != null && filters.isNotEmpty) {
      // print('filters : $filters');

      for (var filter in filters) {
        if (filter.isEqualTo != null) {
          query = query.where(filter.field, isEqualTo: filter.isEqualTo);
        }
        // TODO cater other functions as needed
        if (filter.whereIn != null) {
          query = query.where(filter.field, whereIn: filter.whereIn);
        }
      }
    }

    if (orderBy.isNotEmpty) {
      query = query.orderBy(orderBy, descending: orderDescending);
    }

    result = await query.get(GetOptions(source: source));

    if (null == result ||
        (source == Source.cache && result.documents.isEmpty)) {
      result = await query.get(GetOptions(source: Source.server));
    }

    print('from cache: ${result.metadata.isFromCache}');

    return result.documents;
  }

  Stream<QuerySnapshot> findAllAsStream({
    List<Filter> filters,
    String orderBy = '',
    bool orderDescending = true,
    int limit = 0,
  }) {
    try {
      Stream<QuerySnapshot> result;
      if (filters != null && filters.length > 0) {
        // print('filters : $filters');
        Query query = collection;

        for (var filter in filters) {
          if (filter.isEqualTo != null) {
            query = query.where(filter.field, isEqualTo: filter.isEqualTo);
          }
          if (filter.whereIn != null) {
            query = query.where(filter.field, whereIn: filter.whereIn);
          }
          if (filter.arrayContains != null) {
            query =
                query.where(filter.field, arrayContains: filter.arrayContains);
          }
        }
        if (orderBy.isNotEmpty) {
          query = query.orderBy(orderBy, descending: orderDescending);
        }

        if (limit > 0) {
          query = query.limit(limit);
        }

        result = query.snapshots();
        // print('result ${result.documents.length}');

      } else {
        if (orderBy.isNotEmpty) {
          result = collection
              .orderBy(orderBy, descending: orderDescending)
              .snapshots();
        } else {
          result = collection.snapshots();
        }
      }

      return result;
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future<DocumentSnapshot> findById(id) async {
    try {
      var result = await db.doc('$collectionName/$id').get();
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteById(id) async {
    try {
      await db.doc('$collectionName/$id').delete();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future add({String collection, @required dynamic data}) async {
    try {
      return await db.collection(collection ?? collectionName).add(data);
    } catch (e) {
      print('fail on update $e');
      return null;
    }
  }

  Future<bool> update(id, data) async {
    DocumentSnapshot ds = await db.document('$collectionName/$id').get();
    try {
      await ds.reference.set(
        data,
        SetOptions(merge: true),
      );
      return true;
    } catch (e) {
      print('fail on update $e');
      return null;
    }
  }

  Future<void> batchDelete(QuerySnapshot snapshot) async {
    int i = 0;
    List batchArray = List.from([]);
    batchArray.add(db.batch());
    int batchIndex = 0;

    snapshot.documents.forEach((doc) async {
      if (i == 499) {
        batchArray.add(db.batch());
        i = 0;
        batchIndex++;
      }
      batchArray[batchIndex].delete(doc.reference);
      i++;
    });

    batchArray.forEach((b) async {
      await b.commit();
    });
  }

  Future<void> batchUpdate(List<DocumentReference> refs, data) async {
    int i = 0;
    List<WriteBatch> batchArray = List.from([]);
    batchArray.add(db.batch());
    int batchIndex = 0;

    refs.forEach((doc) async {
      if (i == 499) {
        batchArray.add(db.batch());
        i = 0;
        batchIndex++;
      }
      batchArray[batchIndex].updateData(doc, data);
      i++;
    });

    batchArray.forEach((b) async {
      await b.commit();
    });
  }
}
