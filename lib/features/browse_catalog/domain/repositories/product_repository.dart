import 'package:dartz/dartz.dart';
import 'package:kokorico/core/error/failures.dart';
import 'package:kokorico/features/browse_catalog/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failures, List<Product>>> getProducts();
  Future<Either<Failures, Product>> getProductById({required String id});
}
