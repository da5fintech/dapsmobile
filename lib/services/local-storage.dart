import 'package:hive/hive.dart';

class LocalStorage {
  Future openStorageBox (String storage) async {
    var box = await Hive.openBox(storage);
    return box;
  }

  Future closeStorageBox (box) async {
    box.close();
  }
}
