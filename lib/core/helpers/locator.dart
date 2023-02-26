import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kokorico/features/browsing/data/repositories/user_repository_impl.dart';
import 'package:kokorico/features/browsing/domain/repositories/user_repository.dart';
import 'package:kokorico/features/browsing/domain/usescases/get_all_products.dart';
import 'package:kokorico/features/browsing/domain/usescases/get_one_product.dart';
import 'package:kokorico/features/browsing/domain/usescases/get_user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/browsing/data/datasources/firebase_provider.dart';
import '../../features/browsing/domain/usescases/create_user_profile.dart';
import '../network/network_info.dart';
import 'shared_prefrence_helper.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
  // getIt.registerSingleton<PushNotificationService>(
  //     PushNotificationService(FirebaseMessaging()));

  // Use cases
  getIt.registerLazySingleton(() => GetUserProfile(getIt()));
  getIt.registerLazySingleton(() => CreateUserProfile(getIt()));
  getIt.registerLazySingleton(() => GetOneProduct(getIt()));
  getIt.registerLazySingleton(() => GetAllProducts(getIt()));

  // Repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImplementation(
      firestoreDataProvider: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<FirestoreDataProvider>(
      () => FirestoreDataProvider(firebaseFirestore: getIt()));

  //! Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
