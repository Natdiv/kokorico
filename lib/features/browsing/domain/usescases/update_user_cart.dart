import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class UpdateUserCart {
  UpdateUserCart(this._userRepository);

  final UserRepository _userRepository;

  Future<Either<Failure, void>> call(
    String uid,
    List<Map<String, int>> cart,
  ) async {
    return await _userRepository.updateCart(uid: uid, cart: cart);
  }
}
