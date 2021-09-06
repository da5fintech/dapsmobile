
class BpiAccountModel {
  String accountNumber;
  String accountNumberToken;
  String displayOrder;
  String accountPreferredName;
  String institution;
  String accountType;

  BpiAccountModel({
    this.accountNumber,
    this.accountNumberToken,
    this.displayOrder,
    this.accountPreferredName,
    this.institution,
    this.accountType,
  });

  factory BpiAccountModel.fromMap(Map<String, dynamic> map) {
    BpiAccountModel model = new BpiAccountModel();
    model.accountNumber = map['accountNumber'];
    model.accountNumberToken = map['accountNumberToken'];
    model.displayOrder = map['displayOrder'];
    model.accountPreferredName = map['accountPreferredName'];
    model.institution = map['institution'];
    model.accountType = map['accountType'];
    return model;
  }
}