import 'package:dartz/dartz.dart';
import 'package:kokorico/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetMyOrders implements UseCase<List<AppOrder>, Params> {
  final OrderRepository repository;

  GetMyOrders(this.repository);

  @override
  Future<Either<Failure, List<AppOrder>>> call(Params params) async {
    return await repository.getMyOrders(userId: params.id);
  }
}
