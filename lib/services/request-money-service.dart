import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/models/notification-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/firestore-service.dart';


class RequestMoneyService extends FireStoreService {
  RequestMoneyService() : super(collectionName: 'accounts');

  Future<void> notify (
      Map<String,dynamic> receiver,
      UserModel user,
      NotificationModel notif) async {
    await notifyReceiver(receiver['queryUser'], notif);
    await saveRequest(user, notif);
  }

  Future notifyReceiver (UserModel receiver, NotificationModel notif) async {
    try {
      var result = collection
          .doc(receiver.id)
          .collection('notifications')
          .add({...notif.toMap(), 'status': 'Pending'});
    } catch (err) {
      print('Something went wrong');
      print(err);
    }
  }

  Future saveRequest (UserModel user, notif) async {
    try {
      var result = collection
          .doc(user.id)
          .collection('save_requests')
          .add({...notif.toMap(), 'status': 'Pending'});
    } catch (err) {
      print('Something went wrong');
      print(err);
    }
  }

  Future<List<NotificationModel>> getRequest (UserModel user) async {
    var result = await collection.doc(user.id).collection('notifications')
       .orderBy('createdAt', descending: true)
       .get();

    var notifcations = result.docs.map((res) {
      return NotificationModel.fromDocumentSnapshot(res);
    }).toList();
    return notifcations;
  }

  Future<List<NotificationModel>> getSendRequest (UserModel user) async {
    var result = await collection.doc(user.id).collection('save_requests')
        .orderBy('createdAt', descending: true)
        .get();

    var saveRequests = result.docs.map((res) {
      return NotificationModel.fromDocumentSnapshot(res);
    }).toList();
    return saveRequests;
  }

}