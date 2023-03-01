import 'package:dartz/dartz.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';
import 'package:kokorico/features/browsing/domain/entities/product.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class CreateProduct implements UseCase<void, Product> {
  CreateProduct(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, void>> call(Product product) async {
    return await _productRepository.create(product: product as ProductModel);
  }
}
