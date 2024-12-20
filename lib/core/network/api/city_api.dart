part of '../../_core.dart';

class CityApi {
  const CityApi._();

  static const String baseUrl = 'https://alamat.thecloudalert.com/api/';
  static const String keyAuth = '';

  static const Map<String, dynamic> headers = {
    // 'Authorization': 'Bearer $keyAuth',
    'accept': 'application/json'
  };
  
  static Endpoint allCities() => const Endpoint('kabkota/get', 
    CityApi.headers, 
    // params: {
    //   'page': 1,
    //   'limit': 100
    // }
  );
}