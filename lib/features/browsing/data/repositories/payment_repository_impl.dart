import 'package:kokorico/features/browsing/domain/entities/payment.dart';
import 'package:kokorico/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kokorico/features/browsing/domain/repositories/payment_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/firebase_provider.dart';
import '../datasources/functions_provider.dart';

class PaymentRepositoryImplementation implements PaymentRepository {
  final FirestoreDataProvider firestoreDataProvider;
  final FunctionsProvider functionsProvider;
  final NetworkInfo networkInfo;

  PaymentRepositoryImplementation(
      {required this.firestoreDataProvider,
      required this.functionsProvider,
      required this.networkInfo});

  @override
  Future<Either<Failure, void>> create({required Payment payment}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Payment>>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Payment>> readOne({required String id}) {
    // TODO: implement readOne
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> requestApi(
      {required String phoneNumber, required double amount}) async {
    if (await networkInfo.isConnected) {
      try {
        var result =
            await functionsProvider.payWithMobileMoney(phoneNumber, amount);
        return Right(result);
      } catch (e) {
        final message = e.toString();
        print('Payment Repository Implementation: $message');
        return Left(FirebaseFailure(message));
      }
    } else {
      print('Network Failure');

      return const Left(NetworkFailure('NetworkFailure'));
    }
  }

  @override
  Future<Either<Failure, void>> update(
      {required String id, required Payment payment}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
