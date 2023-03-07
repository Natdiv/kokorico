import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/payment.dart';
import '../repositories/payment_repository.dart';

class MakeMobilePayment {
  MakeMobilePayment(this._paymentRepository);

  final PaymentRepository _paymentRepository;

  Future<Either<Failure, Map<String, dynamic>>> call(Payment payment) async {
    return await _paymentRepository.requestApi(payment: payment);
  }
}
