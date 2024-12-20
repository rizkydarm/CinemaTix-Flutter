part of '../_data.dart';

class CityRemoteDataSource {
  
  final DioHelper _dio = DioHelper(CityApi.baseUrl);

  Future<AllCitiesModel> getAllCities() async {
    final data = await _dio.get<Map>(CityApi.allCities());
    if (data?.containsKey('result') ?? false) {
      return AllCitiesModel.fromJson(data as Map<String, dynamic>);
    } else {
      throw Exception('Result key is not found in allCities data');
    }
  }

}