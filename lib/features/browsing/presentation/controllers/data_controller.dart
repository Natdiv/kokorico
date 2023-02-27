import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helpers/locator.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usescases/get_all_products.dart';

class DataController {
  final GetAllProducts _getAllProducts = getIt<GetAllProducts>();

  Future<Either<Failure, List<Product>>> getProducts() {
    return _getAllProducts(NoParams());
  }
}
