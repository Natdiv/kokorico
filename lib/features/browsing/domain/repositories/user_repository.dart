import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/app_user.dart';

abstract class UserRepository {
  /// Get the current user profile
  /// Only available if the user is connected
  Future<Either<Failure, AppUser>> getProfileUser();
}
