part of '../_domain.dart';

class CityUseCase {

  final CityRepository _repository = CityRepository();

  Future<List<CityEntity>> getAllCities() async {
    return await _repository.getAllCities();
  }
}