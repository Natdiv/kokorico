import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, void>> create({required Product product});
  Future<Either<Failure, List<Product>>> read();
  Future<Either<Failure, Product>> readOne({required String id});

  Future<Either<Failure, void>> update(
      {required String id, required Product product});
  Future<Either<Failure, void>> delete({required String id});

  Future<Either<Failure, List<Product>>> readSome({required List<String> list});
}
