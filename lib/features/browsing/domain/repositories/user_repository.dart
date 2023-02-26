import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/app_user_model.dart';
import '../entities/app_user.dart';

abstract class UserRepository {
  /// Get the current user profile
  /// Only available if the user is connected
  Future<Either<Failure, AppUser>> userProfile({required String uid});

  Future<Either<Failure, List<AppUser>>> read();
  Future<Either<Failure, void>> create({required AppUserModel appUser});
  Future<Either<Failure, void>> update(
      {required String uid, required AppUser appUser});
  Future<Either<Failure, void>> delete({required String uid});
}
