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
