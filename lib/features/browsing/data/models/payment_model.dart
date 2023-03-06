import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/payment.dart';

class PaymentModel extends Payment {
  const PaymentModel(
      {required super.id,
      required super.orderId,
      required super.userId,
      required super.paymentMethod,
      required super.paymentStatus,
      required super.paymentDate,
      required super.paymentAmount,
      required super.paymentCustomerPhone});

  factory PaymentModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final documentSnapshot = snapshot.data()!;
    return PaymentModel(
      id: documentSnapshot['id'],
      orderId: documentSnapshot['orderId'],
      userId: documentSnapshot['userId'],
      paymentMethod: documentSnapshot['paymentMethod'],
      paymentStatus: documentSnapshot['paymentStatus'],
      paymentDate: documentSnapshot['paymentDate'],
      paymentAmount: documentSnapshot['paymentAmount'],
      paymentCustomerPhone: documentSnapshot['paymentCustomerPhone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'orderId': orderId,
      'userId': userId,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentDate': paymentDate,
      'paymentAmount': paymentAmount,
      'paymentCustomerPhone': paymentCustomerPhone,
    };
  }
}
