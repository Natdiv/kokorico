import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/payment_repository.dart';

class MakeMobilePayment {
  MakeMobilePayment(this._paymentRepository);

  final PaymentRepository _paymentRepository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      String phoneNumber, double amount) async {
    return await _paymentRepository.requestApi(
        phoneNumber: phoneNumber, amount: amount);
  }
}
