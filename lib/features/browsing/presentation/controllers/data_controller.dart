import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helpers/locator.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/product.dart';
import '../../domain/usescases/get_all_products.dart';
import '../../domain/usescases/get_cart_products.dart';
import '../../domain/usescases/get_my_orders.dart';
import '../../domain/usescases/makeMobilePayment.dart';
import '../../domain/usescases/update_user_cart.dart';

class DataController {
  final GetAllProducts _getAllProducts = getIt<GetAllProducts>();
  final GetCartProducts _getCartProducts = getIt<GetCartProducts>();
  final MakeMobilePayment _makeMobilePayment = getIt<MakeMobilePayment>();
  final GetMyOrders _getMyOrders = getIt<GetMyOrders>();

  // final GetUserProfile _getUserProfile = getIt<GetUserProfile>();
  final UpdateUserCart _updateCart = getIt<UpdateUserCart>();

  Future<Either<Failure, List<Product>>> getProducts() {
    return _getAllProducts(NoParams());
  }

  Future<Either<Failure, List<AppOrder>>> getMyOrders(String userId) {
    return _getMyOrders(Params(id: userId));
  }

  /// Returns a list of products from the cart
  Future<Either<Failure, List<Product>>> getCart(List<Map<String, int>> cart) {
    var list = cart.map((e) => e.keys.first).toList();
    return _getCartProducts(list);
  }

  /// Updates the cart in the database
  Future<Either<Failure, void>> updateCart(
      String uid, List<Map<String, int>> cart) {
    return _updateCart(uid, cart);
  }

  /// Makes a mobile payment
  Future<Either<Failure, Map<String, dynamic>>> makeMobilePayment(
      Payment payment) {
    return _makeMobilePayment(payment);
  }
}
