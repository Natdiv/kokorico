import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kokorico/features/browsing/data/datasources/functions_provider.dart';
import 'package:kokorico/features/browsing/data/repositories/payment_repository_impl.dart';
import 'package:kokorico/features/browsing/data/repositories/user_repository_impl.dart';
import 'package:kokorico/features/browsing/domain/repositories/product_repository.dart';
import 'package:kokorico/features/browsing/domain/repositories/user_repository.dart';
import 'package:kokorico/features/browsing/domain/usescases/get_all_products.dart';
import 'package:kokorico/features/browsing/domain/usescases/get_one_product.dart';
import 'package:kokorico/features/browsing/domain/usescases/get_user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/browsing/data/datasources/firebase_provider.dart';
import '../../features/browsing/data/repositories/order_repository_impl.dart';
import '../../features/browsing/data/repositories/product_repository_impl.dart';
import '../../features/browsing/domain/repositories/order_repository.dart';
import '../../features/browsing/domain/repositories/payment_repository.dart';
import '../../features/browsing/domain/usescases/create_order.dart';
import '../../features/browsing/domain/usescases/create_product.dart';
import '../../features/browsing/domain/usescases/create_user_profile.dart';
import '../../features/browsing/domain/usescases/get_cart_products.dart';
import '../../features/browsing/domain/usescases/get_my_orders.dart';
import '../../features/browsing/domain/usescases/makeMobilePayment.dart';
import '../../features/browsing/domain/usescases/update_user_cart.dart';
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
  getIt.registerLazySingleton(() => CreateProduct(getIt()));
  getIt.registerLazySingleton(() => GetCartProducts(getIt()));
  getIt.registerLazySingleton(() => UpdateUserCart(getIt()));
  getIt.registerLazySingleton(() => CreateOrder(getIt()));
  getIt.registerLazySingleton(() => MakeMobilePayment(getIt()));
  getIt.registerLazySingleton(() => GetMyOrders(getIt()));

  // Repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImplementation(
      firestoreDataProvider: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImplementation(
      firestoreDataProvider: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImplementation(
      firestoreDataProvider: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImplementation(
      firestoreDataProvider: getIt(),
      functionsProvider: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<FirestoreDataProvider>(
      () => FirestoreDataProvider(firebaseFirestore: getIt()));
  getIt.registerLazySingleton<FunctionsProvider>(
      () => FunctionsProvider(functions: getIt()));

  //! Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseFunctions.instance);
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
