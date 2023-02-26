import 'package:dartz/dartz.dart';
import 'package:kokorico/core/usecases/usecase.dart';
import 'package:kokorico/features/browsing/domain/entities/app_user.dart';
import 'package:kokorico/features/browsing/domain/repositories/user_repository.dart';

import '../../../../core/error/failures.dart';

class GetUserProfile implements UseCase<AppUser, Params> {
  GetUserProfile(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, AppUser>> call(Params params) async {
    return await _userRepository.userProfile(uid: params.id);
  }
}
