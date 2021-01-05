import 'package:swipe/common/errors.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/firestore-service.dart';

class AccountService extends FireStoreService {
  AccountService() : super(collectionName: "accounts");

  Future<double> getWalletAmount() async {
    try {
      return 25.00;
    } on ApiResponseError catch (e) {
      return 0;
    }
  }

  Future<UserModel> findOrCreate(String uid, String email,
      {String name, String photoURL}) async {
    var result = await findById(uid);
    if (result.exists) {
      return UserModel.fromDocumentSnapshot(result);
    } else {
      var user =
          UserModel(id: uid, email: email, name: name, photoURL: photoURL);
      await update(uid, user.toMap());
      return user;
    }
  }
}
