import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/order.dart';

class OrderModel extends AppOrder {
  OrderModel(
      {required super.id,
      required super.userId,
      required super.status,
      required super.paymentMethod,
      required super.paymentStatus,
      required super.deliveryMethod,
      required super.deliveryStatus,
      required super.deliveryAddress,
      required super.deliveryCity,
      required super.deliveryCountry,
      required super.deliveryPostalCode,
      required super.deliveryPhone,
      required super.deliveryEmail,
      required super.deliveryNotes,
      required super.deliveryDate,
      required super.deliveryTime,
      required super.deliveryPrice,
      required super.totalPrice,
      required super.products,
      required super.createdAt,
      required super.updatedAt});

  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final documentSnapshot = snapshot.data()!;

    return OrderModel(
      id: documentSnapshot['id'],
      userId: documentSnapshot['userId'],
      status: documentSnapshot['status'],
      paymentMethod: documentSnapshot['paymentMethod'],
      paymentStatus: documentSnapshot['paymentStatus'],
      deliveryMethod: documentSnapshot['deliveryMethod'],
      deliveryStatus: documentSnapshot['deliveryStatus'],
      deliveryAddress: documentSnapshot['deliveryAddress'],
      deliveryCity: documentSnapshot['deliveryCity'],
      deliveryCountry: documentSnapshot['deliveryCountry'],
      deliveryPostalCode: documentSnapshot['deliveryPostalCode'],
      deliveryPhone: documentSnapshot['deliveryPhone'],
      deliveryEmail: documentSnapshot['deliveryEmail'],
      deliveryNotes: documentSnapshot['deliveryNotes'],
      deliveryDate: documentSnapshot['deliveryDate'],
      deliveryTime: documentSnapshot['deliveryTime'],
      deliveryPrice: documentSnapshot['deliveryPrice'],
      totalPrice: documentSnapshot['totalPrice'],
      products: documentSnapshot['products'],
      createdAt: documentSnapshot['createdAt'],
      updatedAt: documentSnapshot['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'deliveryMethod': deliveryMethod,
      'deliveryStatus': deliveryStatus,
      'deliveryAddress': deliveryAddress,
      'deliveryCity': deliveryCity,
      'deliveryCountry': deliveryCountry,
      'deliveryPostalCode': deliveryPostalCode,
      'deliveryPhone': deliveryPhone,
      'deliveryEmail': deliveryEmail,
      'deliveryNotes': deliveryNotes,
      'deliveryDate': deliveryDate,
      'deliveryTime': deliveryTime,
      'deliveryPrice': deliveryPrice,
      'totalPrice': totalPrice,
      'products': products,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
