import 'package:dartz/dartz.dart';
import 'package:kokorico/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetCartProducts implements UseCase<List<Product>, List<String>> {
  GetCartProducts(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, List<Product>>> call(List<String> param) async {
    return await _productRepository.readSome(list: param);
  }
}
