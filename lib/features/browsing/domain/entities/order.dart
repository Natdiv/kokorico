import 'package:equatable/equatable.dart';

class AppOrder extends Equatable {
  String? id;
  final String userId;

  /// Defines the status of the order
  /// It can be:
  /// - pending
  /// - processing
  /// - completed
  /// - cancelled
  final String status;

  /// Defines the payment method
  /// Cash on delivery or online payment
  final String paymentMethod;

  /// Defines the payment status
  /// Paid or pending
  final String paymentStatus;
  // final String deliveryMethod;
  final String deliveryStatus;
  final String deliveryAddress;
  final String? referenceAddress;
  final String? deliveryCity;
  final String? deliveryCountry;
  // final String? deliveryPostalCode;
  final String deliveryPhone;
  final String paymentPhone;
  final String? deliveryEmail;
  final String? deliveryNotes;
  final int deliveryDate;

  /// [deliveryPrice] represent the sum of total price with the delivery fees
  final double deliveryPrice;
  final double totalPrice;
  final List<Map<String, int>> products;
  final int createdAt;
  final int updatedAt;

  AppOrder({
    this.id,
    required this.userId,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.deliveryAddress,
    required this.referenceAddress,
    required this.deliveryCity,
    required this.deliveryCountry,
    required this.deliveryPhone,
    required this.paymentPhone,
    required this.deliveryEmail,
    required this.deliveryNotes,
    required this.deliveryDate,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  set setId(String id) {
    this.id = id;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        status,
        paymentMethod,
        paymentStatus,
        deliveryStatus,
        deliveryAddress,
        referenceAddress,
        deliveryCity,
        deliveryCountry,
        deliveryPhone,
        paymentPhone,
        deliveryEmail,
        deliveryNotes,
        deliveryDate,
        deliveryPrice,
        totalPrice,
        products,
        createdAt,
        updatedAt,
      ];
}
