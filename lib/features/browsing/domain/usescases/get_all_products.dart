import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProducts implements UseCase<List<Product>, NoParams> {
  GetAllProducts(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await _productRepository.read();
  }
}
