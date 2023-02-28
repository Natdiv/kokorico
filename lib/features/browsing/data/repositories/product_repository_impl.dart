import 'package:kokorico/features/browsing/domain/entities/product.dart';

import 'package:kokorico/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/firebase_provider.dart';

class ProductRepositoryImplementation implements ProductRepository {
  final FirestoreDataProvider firestoreDataProvider;
  final NetworkInfo networkInfo;

  ProductRepositoryImplementation(
      {required this.firestoreDataProvider, required this.networkInfo});

  @override
  Future<Either<Failure, void>> create({required Product product}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> read() async {
    if (await networkInfo.isConnected) {
      try {
        var result = await firestoreDataProvider.getProducts();
        return Right(result);
      } catch (e) {
        final message = e.toString();
        print('Product Repository Implementation: $message');
        return Left(FirebaseFailure(message));
      }
    } else {
      print('Network Failure');
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> readOne({required String id}) {
    // TODO: implement readOne
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> update(
      {required String id, required Product product}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
