import 'package:equatable/equatable.dart';

class AppOrder extends Equatable {
  String? id;
  final String userId;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final String deliveryMethod;
  final String deliveryStatus;
  final String deliveryAddress;
  final String deliveryCity;
  final String deliveryCountry;
  final String deliveryPostalCode;
  final String deliveryPhone;
  final String deliveryEmail;
  final String deliveryNotes;
  final String deliveryDate;
  final String deliveryTime;
  final String deliveryPrice;
  final String totalPrice;
  final List<Map<String, int>> products;
  final int createdAt;
  final int updatedAt;

  AppOrder({
    this.id,
    required this.userId,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryMethod,
    required this.deliveryStatus,
    required this.deliveryAddress,
    required this.deliveryCity,
    required this.deliveryCountry,
    required this.deliveryPostalCode,
    required this.deliveryPhone,
    required this.deliveryEmail,
    required this.deliveryNotes,
    required this.deliveryDate,
    required this.deliveryTime,
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
        deliveryMethod,
        deliveryStatus,
        deliveryAddress,
        deliveryCity,
        deliveryCountry,
        deliveryPostalCode,
        deliveryPhone,
        deliveryEmail,
        deliveryNotes,
        deliveryDate,
        deliveryTime,
        deliveryPrice,
        totalPrice,
        products,
        createdAt,
        updatedAt,
      ];
}
