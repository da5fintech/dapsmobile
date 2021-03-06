import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:daps/common/errors.dart';
import 'package:daps/models/transaction-model.dart';
import 'package:daps/models/user-model.dart';
import 'package:daps/services/firestore-service.dart';

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
    await update(user.emailAddress, user.toMap());
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
          id: uid, emailAddress: email, displayName: name, photoURL: photoURL);
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

  Future<UserModel> updateUser(firstname, lastname, mobileNumber, address, UserModel user) async {
    user.firstName = firstname;
    user.lastName = lastname;
    user.mobileNumber = mobileNumber;
    user.address = address;
    user.displayName = firstname + " " + lastname;
    user.updatedAt = DateTime.now();
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

  Future<String> getLatestAppVersion() async {
    try {
      var query = await db.collection('app_version').get();
      return query.docs.first['version'];
    } catch (err) {
      rethrow;
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

  Future<Map<String, dynamic>> findMobileUser (String mobileNumber) async {
    var result = await collection
        .where('mobileNumber', isEqualTo: mobileNumber)
        .get()
        .then((value) {
          if(value.docs.length > 0) {
            print('has items');
            return {
              'status': true,
              'reason': 'User mobile number found',
              'queryUser': UserModel.fromDocumentSnapshot(value.docs.first),
            };
          } else {
            print('no items');
            return {
              'status': false,
              'reason': 'Something went wrong',
              'queryUser': [],
            };
          }

        })
        .catchError((error) {
          return {
            'status': false,
            'reason': 'Something went wrong!',
          };
        });
    return result;
  }

}
