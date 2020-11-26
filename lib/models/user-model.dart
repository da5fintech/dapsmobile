class UserModel {
  String id;

  UserModel({
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> data, {id}) {
    // Map geoLocationMap = json['geoLocation'] as Map;
    // var geoLocation = null != geoLocationMap ? new GeoLocation(lat: geoLocationMap['lat'], lon: geoLocationMap['lon']) : null;

    return UserModel(
      id: id,
    );
  }
}
