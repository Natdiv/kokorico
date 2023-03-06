import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, void>> create({required AppOrder order});
  Future<Either<Failure, List<AppOrder>>> read();
  Future<Either<Failure, AppOrder>> readOne({required String id});

  Future<Either<Failure, void>> update(
      {required String id, required AppOrder order});
  Future<Either<Failure, void>> delete({required String id});

  // Future<Either<Failure, List<Order>>> readSome({required List<String> list});
}
