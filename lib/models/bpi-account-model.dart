
class BpiAccountModel {
  String accessToken;
  String accountNumber;
  String accountNumberToken;
  String displayOrder;
  String accountPreferredName;
  String institution;
  String accountType;
  String mobileNumber;
  String mobileNumberToken;
  double amount;
  String transactionId;

  BpiAccountModel({
    this.accessToken,
    this.accountNumber,
    this.accountNumberToken,
    this.displayOrder,
    this.accountPreferredName,
    this.institution,
    this.accountType,
    this.mobileNumber,
    this.mobileNumberToken,
    this.amount,
    this.transactionId,
  });

  factory BpiAccountModel.fromMap(Map<String, dynamic> map) {
    BpiAccountModel model = new BpiAccountModel();
    model.accessToken = map['accessToken'];
    model.accountNumber = map['accountNumber'];
    model.accountNumberToken = map['accountNumberToken'];
    model.displayOrder = map['displayOrder'];
    model.accountPreferredName = map['accountPreferredName'];
    model.institution = map['institution'];
    model.accountType = map['accountType'];
    model.mobileNumber = map['mobileNumber'];
    model.mobileNumberToken = map['mobileNumberToken'];
    model.amount = map['amount'];
    model.transactionId = map['transactionId'];
    return model;
  }
}