import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/gifticon/entities/point_transaction_entity.dart';
import 'package:pedal/domain/gifticon/repositories/gifticon_repository.dart';

class GetPointTransactionsUseCase {
  final GifticonRepository _repository;
  GetPointTransactionsUseCase(this._repository);

  Future<({Failure? failure, List<PointTransactionEntity>? data})> call() {
    return _repository.getPointTransactions();
  }
}
