import 'package:swipe/models/phlippines-model.dart';
import 'package:swipe/services/da5-service.dart';

class PhRegionsService extends Da5Service {
  Future<List<RegionModel>> fetchRegions() async {
    List<RegionModel> regions = [];
    var result = await phApi(endpoint: 'regions');
    result.forEach((res) {
      regions.add(RegionModel.fromMap(res));
    });

    return regions;
  }

  Future<List<ProvinceModel>> fetchProvince(String query) async {
    List<ProvinceModel> provinces = [];
    var result = await phApi(endpoint: 'provinces', req: query);
    result.forEach((res) {
      provinces.add(ProvinceModel.fromMap(res));
    });
    return provinces;
  }

  Future<List<CityModel>> fetchCities(String query) async {
    List<CityModel> cities = [];
    var result = await phApi(endpoint: 'cities', req: query);
    result.forEach((res) {
      cities.add(CityModel.fromMap(res));
    });
    return cities;
  }

  Future<List<BarangayModel>> fetchBarangays(String query) async {
    List<BarangayModel> barangays = [];
    var result = await phApi(endpoint: 'barangays', req: query);
    result.forEach((res) {
      barangays.add(BarangayModel.fromMap(res));
    });

    return barangays;
  }
}
