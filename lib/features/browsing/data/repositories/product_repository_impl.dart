import 'package:kokorico/features/browsing/domain/entities/product.dart';

import 'package:kokorico/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImplementation implements ProductRepository {
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
  Future<Either<Failure, List<Product>>> read() {
    // TODO: implement read
    throw UnimplementedError();
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
