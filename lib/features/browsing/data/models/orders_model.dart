import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/order.dart';

class OrderModel extends AppOrder {
  OrderModel({
    super.id,
    required super.userId,
    required super.status,
    required super.paymentMethod,
    required super.paymentStatus,
    // required super.deliveryMethod,
    required super.deliveryStatus,
    required super.deliveryAddress,
    required super.referenceAddress,
    required super.deliveryCity,
    required super.deliveryCountry,
    // required super.deliveryPostalCode,
    required super.deliveryPhone,
    required super.paymentPhone,
    required super.deliveryEmail,
    required super.deliveryNotes,
    required super.deliveryDate,
    required super.deliveryPrice,
    required super.totalPrice,
    required super.products,
    required super.createdAt,
    required super.updatedAt,
  });

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
      deliveryStatus: documentSnapshot['deliveryStatus'],
      deliveryAddress: documentSnapshot['deliveryAddress'],
      referenceAddress: documentSnapshot['referenceAddress'],
      deliveryCity: documentSnapshot['deliveryCity'],
      deliveryCountry: documentSnapshot['deliveryCountry'],
      deliveryPhone: documentSnapshot['deliveryPhone'],
      paymentPhone: documentSnapshot['paymentPhone'],
      deliveryEmail: documentSnapshot['deliveryEmail'],
      deliveryNotes: documentSnapshot['deliveryNotes'],
      deliveryDate: documentSnapshot['deliveryDate'],
      deliveryPrice: documentSnapshot['deliveryPrice'],
      totalPrice: documentSnapshot['totalPrice'],
      products: (documentSnapshot['products'] as Iterable).map((e) {
        String key = e.keys.first;
        int value = e.values.first.toInt();
        return {key: value};
      }).toList(),
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
      'deliveryStatus': deliveryStatus,
      'deliveryAddress': deliveryAddress,
      'referenceAddress': referenceAddress,
      'deliveryCity': deliveryCity,
      'deliveryCountry': deliveryCountry,
      'deliveryPhone': deliveryPhone,
      'paymentPhone': paymentPhone,
      'deliveryEmail': deliveryEmail,
      'deliveryNotes': deliveryNotes,
      'deliveryDate': deliveryDate,
      'deliveryPrice': deliveryPrice,
      'totalPrice': totalPrice,
      'products': products,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
