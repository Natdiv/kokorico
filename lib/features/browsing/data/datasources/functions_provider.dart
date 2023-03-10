import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import '../models/orders_model.dart';

class FunctionsProvider {
  final FirebaseFunctions functions;

  FunctionsProvider({required this.functions});

  Future<Map<String, dynamic>> payWithMobileMoney(OrderModel appOrder) async {
    // functions.useFunctionsEmulator("127.0.0.1", 5001);

    print('Commande: ${appOrder.toFirestore()}');

    await Future.delayed(const Duration(seconds: 2));
    final HttpsCallable mobileMoneyPayment = functions.httpsCallable(
      'mobileMoneyPayment',
    );

    return {
      'status': true,
      'message': 'Order Placed Successfully',
    };
    // return await mobileMoneyPayment.call(<String, dynamic>{
    //   'phoneNumber': phoneNumber,
    //   'amout': amount,
    // }).then((value) {
    //   print('Functions Provider: ${value}');
    //   return value.data as Map<String, dynamic>;
    // });
  }
}
