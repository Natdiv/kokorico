import 'package:dartz/dartz.dart';
import 'package:kokorico/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetOneProduct implements UseCase<Product, Params> {
  GetOneProduct(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, Product>> call(Params params) async {
    return await _productRepository.readOne(id: params.id);
  }
}
