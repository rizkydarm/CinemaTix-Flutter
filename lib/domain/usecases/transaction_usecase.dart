part of '../_domain.dart';

class TransactionUseCase {

  final TransactionRepository _repository = getit.get<TransactionRepository>();

  Future<void> add(TransactionEntity e) => _repository.add(e);

  Future<List<TransactionEntity>> fetchAllByUser(UserEntity user) => _repository.fetchAllByUser(user);
}