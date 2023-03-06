import 'package:cloud_functions/cloud_functions.dart';

class FunctionsProvider {
  final FirebaseFunctions functions;

  FunctionsProvider({required this.functions});

  Future<Map<String, dynamic>> payWithMobileMoney(
      String phoneNumber, double amount) async {
    // functions.useFunctionsEmulator("127.0.0.1", 5001);
    final HttpsCallable mobileMoneyPayment = functions.httpsCallable(
      'mobileMoneyPayment',
    );

    return {
      'status': true,
      'amout': amount,
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
