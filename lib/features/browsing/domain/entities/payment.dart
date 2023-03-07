import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  String? id;
  final String orderId;
  final String userId;
  final String paymentMethod;
  final String paymentStatus;
  final int paymentDate;
  final double paymentAmount;
  final String paymentCustomerPhone;

  Payment(
      {this.id,
      required this.orderId,
      required this.userId,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.paymentDate,
      required this.paymentAmount,
      required this.paymentCustomerPhone});

  @override
  List<Object?> get props => [
        id,
        orderId,
        userId,
        paymentMethod,
        paymentStatus,
        paymentDate,
        paymentAmount,
        paymentCustomerPhone,
      ];
}
