import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/models/user-model.dart';
part 'application-store.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {
  @observable
  UserModel user;

  _ApplicationStore(SharedPreferences prefs) {}
}
