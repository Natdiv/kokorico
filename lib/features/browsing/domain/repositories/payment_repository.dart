import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> create({required Payment payment});
  Future<Either<Failure, List<Payment>>> read();
  Future<Either<Failure, Payment>> readOne({required String id});

  Future<Either<Failure, void>> update(
      {required String id, required Payment payment});
  Future<Either<Failure, void>> delete({required String id});

  Future<Either<Failure, Map<String, dynamic>>> requestApi(
      {required Payment payment});

  // Future<Either<Failure, List<Order>>> readSome({required List<String> list});
}
