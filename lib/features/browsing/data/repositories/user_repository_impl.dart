import 'package:kokorico/features/browsing/domain/entities/app_user.dart';
import 'package:kokorico/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kokorico/features/browsing/domain/repositories/user_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/firebase_provider.dart';
import '../models/app_user_model.dart';

class UserRepositoryImplementation implements UserRepository {
  final FirestoreDataProvider firestoreDataProvider;
  final NetworkInfo networkInfo;

  UserRepositoryImplementation(
      {required this.firestoreDataProvider, required this.networkInfo});

  @override
  Future<Either<Failure, void>> create({required AppUserModel appUser}) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await firestoreDataProvider.createUser(appUser);
        return Right(result);
      } catch (e) {
        final message = e.toString();
        return Left(FirebaseFailure(message));
      }
    } else {
      return const Left(NetworkFailure('NetworkFailure'));
    }
  }

  @override
  Future<Either<Failure, void>> delete({required String uid}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AppUser>>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> update(
      {required String uid, required AppUser appUser}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AppUser>> userProfile({required String uid}) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await firestoreDataProvider.getProfileUser(uid: uid);
        return Right(result!);
      } catch (e) {
        print('ON FIREBASE FAILURE');
        final message = e.toString();
        return Left(FirebaseFailure(message));
      }
    } else {
      return const Left(NetworkFailure('NetworkFailure'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCart(
      {required String uid, required List<Map<String, int>> cart}) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await firestoreDataProvider.updateCart(uid, cart);
        return Right(result);
      } catch (e) {
        final message = e.toString();
        return Left(FirebaseFailure(message));
      }
    } else {
      return const Left(NetworkFailure('NetworkFailure'));
    }
  }
}
