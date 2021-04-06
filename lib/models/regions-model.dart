
class Region {
  int id;
  String psgcCode;
  String regDesc;
  String regCode;

  Region({
    this.id,
    this.psgcCode,
    this.regDesc,
    this.regCode,
  });

  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'psgcCode': psgcCode,
      'regDesc': regDesc,
      'regCode': regCode
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      id: map['id'],
      psgcCode: map['psgcCode'],
      regDesc: map['regDesc'],
      regCode: map['regCode'],
    );
  }
}