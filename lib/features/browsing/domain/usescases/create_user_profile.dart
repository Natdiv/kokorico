import 'package:dartz/dartz.dart';
import 'package:kokorico/core/usecases/usecase.dart';
import 'package:kokorico/features/browsing/data/models/app_user_model.dart';

import '../../../../core/error/failures.dart';
import '../entities/app_user.dart';
import '../repositories/user_repository.dart';

class CreateUserProfile implements UseCase<void, AppUser> {
  CreateUserProfile(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, void>> call(AppUser appUser) async {
    return await _userRepository.create(appUser: appUser as AppUserModel);
  }
}
