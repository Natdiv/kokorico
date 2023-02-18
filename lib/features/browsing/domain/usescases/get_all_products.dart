import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProducts implements UseCase<List<Product>, String> {
  GetAllProducts(this._productRepository);

  ProductRepository _productRepository;

  @override
  Future<Either<Failure, List<Product>>> call(String id) async {
    return await _productRepository.getProducts();
  }
}
