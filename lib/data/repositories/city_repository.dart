part of '../_data.dart';

class CityRepository implements Repository {
  
  final CityRemoteDataSource _remoteDataSource = CityRemoteDataSource();

  Future<List<CityEntity>> getAllCities() {
    return _remoteDataSource.getAllCities().then((value) => value.result!.map((e) => CityEntity(
      id: e.id!,
      name: e.text!,
    )).toList());
  }
}