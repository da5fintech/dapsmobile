import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daps/common/util.dart';
import 'package:daps/models/notification-model.dart';
import 'package:daps/models/user-model.dart';
import 'package:daps/services/account-service.dart';
import 'package:daps/services/firestore-service.dart';

class RequestMoneyService extends FireStoreService {
  RequestMoneyService() : super(collectionName: 'accounts');
  AppUtil _appUtil = AppUtil();

  Future<void> notify(Map<String, dynamic> receiver, UserModel user,
      NotificationModel notif) async {
    var uid = _appUtil.uid();
    await notifyReceiver(receiver['queryUser'], notif, uid);
    await saveRequest(user, notif, uid);
  }

  Future notifyReceiver(
      UserModel receiver, NotificationModel notif, int uid) async {
    try {
      var result = collection.doc(receiver.id).collection('notifications').add(
          {...notif.toMap(), 'status': 'Pending', 'isSeen': false, 'uid': uid});
    } catch (err) {
      print('Something went wrong');
      print(err);
    }
  }

  Future<List<NotificationModel>> isNotificationSeen(
      UserModel user, List<NotificationModel> notifications) async {
    List<NotificationModel> a = notifications.map((notif) {
      if (!notif.isSeen) {
        // getUnseenNotifications.add(notif);
        update('${user.id}/notifications/${notif.id}',
            {...notif.toMap(), 'isSeen': true});
        notif.isSeen = true;
        return notif;
      } else {
        return notif;
      }
    }).toList();
    return a;
  }

  Future updateRequestStatus(
      UserModel user, NotificationModel notification) async {
    try {
      NotificationModel sender = await findSender(
          '$collectionName/${notification.ownerId}/save_requests',
          notification.uid);
      await update('${notification.ownerId}/save_requests/${sender.id}',
          {...sender.toMap(), 'status': 'Approved'});
      await deleteById('${user.id}/notifications/${notification.id}');
    } catch (err) {
      print('Something went wrong');
      print(err);
    }
  }

  Future saveRequest(UserModel user, notif, int uid) async {
    try {
      var result = collection
          .doc(user.id)
          .collection('save_requests')
          .add({...notif.toMap(), 'status': 'Pending', 'uid': uid});
    } catch (err) {
      print('Something went wrong');
      print(err);
    }
  }

  Future<List<NotificationModel>> getRequest(UserModel user) async {
    var result = await collection
        .doc(user.id)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .get();

    var notifcations = result.docs.map((res) {
      return NotificationModel.fromDocumentSnapshot(res);
    }).toList();
    return notifcations;
  }

  Future<List<NotificationModel>> getSendRequest(UserModel user) async {
    var result = await collection
        .doc(user.id)
        .collection('save_requests')
        .orderBy('createdAt', descending: true)
        .get();

    var saveRequests = result.docs.map((res) {
      return NotificationModel.fromDocumentSnapshot(res);
    }).toList();
    return saveRequests;
  }

  Future<NotificationModel> findSender(pathName, uid) async {
    var result = await db
        .collection(pathName)
        .where('uid', isEqualTo: uid)
        .get()
        .then((res) {
      return NotificationModel.fromDocumentSnapshot(res.docs.first);
    }).catchError((err) {
      print(err);
    });
    return result;
  }

  Future<NotificationModel> findReceiver(pathName, uid) async {
    var result = await db
        .collection(pathName)
        .where('uid', isEqualTo: uid)
        .get()
        .then((res) {
      return NotificationModel.fromDocumentSnapshot(res.docs.first);
    }).catchError((err) {
      print(err);
    });
    return result;
  }

  Future deleteRequest(
      UserModel user,
      NotificationModel notification) async {
    await deleteById('${user.id}/notifications/${notification.id}');
  }

  Future deleteSendRequest(
      UserModel user,
      NotificationModel notification) async {
    await deleteById('${user.id}/save_requests/${notification.id}');
    var a = await findReceiver('$collectionName/${notification.receiverId}/notifications', notification.uid);
    if(a == null) return null;
    await update('${notification.receiverId}/notifications/${a.id}',
      {...notification.toMap(), 'status': 'Closed'}
    );
  }
}
