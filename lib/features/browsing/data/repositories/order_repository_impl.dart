import 'package:kokorico/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/firebase_provider.dart';
import '../models/orders_model.dart';

class OrderRepositoryImplementation implements OrderRepository {
  final FirestoreDataProvider firestoreDataProvider;
  final NetworkInfo networkInfo;

  OrderRepositoryImplementation(
      {required this.firestoreDataProvider, required this.networkInfo});

  @override
  Future<Either<Failure, void>> create({required AppOrder order}) async {
    if (await networkInfo.isConnected) {
      try {
        var result =
            await firestoreDataProvider.createOrder(order as OrderModel);
        return Right(result);
      } catch (e) {
        final message = e.toString();
        return Left(FirebaseFailure(message));
      }
    } else {
      return const Left(NetworkFailure('NetworkFailure'));
    }
  }

  @override
  Future<Either<Failure, void>> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AppOrder>>> read() async {
    if (await networkInfo.isConnected) {
      try {
        var result = await firestoreDataProvider.getOrders();
        return Right(result);
      } catch (e) {
        final message = e.toString();
        print('Product Repository Implementation: $message');
        return Left(FirebaseFailure(message));
      }
    } else {
      print('Network Failure');
      return const Left(NetworkFailure('NetworkFailure'));
    }
  }

  @override
  Future<Either<Failure, AppOrder>> readOne({required String id}) {
    // TODO: implement readOne
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> update(
      {required String id, required AppOrder order}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AppOrder>>> getMyOrders(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await firestoreDataProvider.getMyOrders(userId);
        return Right(result);
      } catch (e) {
        final message = e.toString();
        print('Order Repository Implementation: $message');
        return Left(FirebaseFailure(message));
      }
    } else {
      print('Network Failure');
      return const Left(NetworkFailure('NetworkFailure'));
    }
  }
}
