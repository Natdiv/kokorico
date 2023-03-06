import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class CreateOrder implements UseCase<void, AppOrder> {
  CreateOrder(this._orderRepository);

  final OrderRepository _orderRepository;

  @override
  Future<Either<Failure, void>> call(AppOrder order) async {
    return await _orderRepository.create(order: order);
  }
}
