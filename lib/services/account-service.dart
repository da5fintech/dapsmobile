import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/firestore-service.dart';

class AccountService extends FireStoreService {
  AccountService() : super(collectionName: "accounts");

  Future<double> getWalletAmount(UserModel user) async {
    try {
      var updatedUser = await getAccount(user.id);
      return updatedUser.balance;
    } on ApiResponseError catch (e) {
      return 0;
    }
  }

  Future<double> getSwipePoints(UserModel user) async {
    try {
      var updatedUser = await getAccount(user.id);
      return updatedUser.swipePoints;
    } on ApiResponseError catch(e) {
      return 0;
    }
  }

  Future<UserModel> create(UserModel user) async {
    await update(user.id, user.toMap());
    return user;
  }

  Future<UserModel> getAccount(String uid) async {
    var result = await findById(uid);
    print("result.exists ${result.exists}");
    if (result.exists) {
      return UserModel.fromDocumentSnapshot(result);
    }
    return null;
  }

  Future<UserModel> findOrCreate(String uid, String email,
      {String name, String photoURL}) async {
    var result = await findById(uid);
    if (result.exists) {
      return UserModel.fromDocumentSnapshot(result);
    } else {
      var user = UserModel(
          id: uid, email: email, displayName: name, photoURL: photoURL);
      await update(uid, user.toMap());
      return user;
    }
  }

  Future<bool> updatePin(String uid, String mpin) async {
    var result = await findById(uid);
    if(result.exists) {
      //update pin user
      UserModel user = UserModel.fromDocumentSnapshot(result);
      user.mpin = mpin;
      bool isUpdated = await update(uid, user.toMap());
      return isUpdated;
    } else {
      return false;
    }
  }

  Future<UserModel> updateUser(firstname, lastname, mobileNumber, UserModel user) async {
    user.firstName = firstname;
    user.lastName = lastname;
    user.mobileNumber = mobileNumber;
    user.displayName = firstname + " " + lastname;
    UserModel updatedUser = await create(user);
    return updatedUser;
  }

  Future<UserModel> findUserByMobile(String mobileNumber) async {
    try {
      var query = await db.collection(collectionName).get();
      DocumentSnapshot result = query.docs.firstWhere((el) {
        return el['mobileNumber'] == mobileNumber ? el['mobileNumber'] : null;
      });
      if(result == null) return null;
      print("User find!");
      UserModel userResult = UserModel.fromDocumentSnapshot(result);
      return userResult;
    } catch (e) {
      return null;
    }
  }

  Future<List<TransactionRecordModel>> getTransactionRecords(String uid) async {
    var result = await collection
        .doc(uid)
        .collection('transactions')
        .orderBy("creationDate", descending: true)
        .get();

    var records = result.docs.map((e) {
      return TransactionRecordModel.fromDocumentSnapshot(e);
    }).toList();

    return records;
  }
}
