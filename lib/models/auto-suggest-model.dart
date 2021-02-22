import 'package:hive/hive.dart';
import 'package:swipe/common/constants.dart';


part 'auto-suggest-model.g.dart';

@HiveType(typeId: 7)
class AutoSuggest extends HiveObject {
  @HiveField(0)
  SwipeServiceOffering type;

  AutoSuggest({this.type});
}

@HiveType(typeId: 8)
class BuyLoadSuggest extends AutoSuggest {
  @HiveField(1)
  String mobileNumber;

  BuyLoadSuggest({
    this.mobileNumber,
    SwipeServiceOffering type
  }) : super(type: type);
}