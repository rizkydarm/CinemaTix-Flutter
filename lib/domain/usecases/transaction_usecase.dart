part of '../_domain.dart';

class TransactionUseCase {

  final TransactionRepository _repository = getit.get<TransactionRepository>();

  Future<void> add(TransactionEntity e) async {
    await _repository.add(e);
  }
}