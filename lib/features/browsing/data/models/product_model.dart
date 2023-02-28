import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required double price,
    required String unit,
    required double rating,
    required int reviews,
    required bool isFavorite,
    required bool isPopular,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          price: price,
          unit: unit,
          rating: rating,
          reviews: reviews,
          isFavorite: isFavorite,
          isPopular: isPopular,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      unit: json['unit'],
      rating: double.parse(json['rating']),
      reviews: int.parse(json['reviews']),
      isFavorite: json['isFavorite'],
      isPopular: json['isPopular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'unit': unit,
      'rating': rating,
      'reviews': reviews,
      'isFavorite': isFavorite,
      'isPopular': isPopular,
    };
  }

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final documentSnapshot = snapshot.data();

    print("PRODUCT FROM FIRESTORE: ${documentSnapshot}");
    return ProductModel(
      id: snapshot.id,
      name: documentSnapshot?['name'] ?? '',
      description: documentSnapshot?['description'] ?? '',
      imageUrl: documentSnapshot?['imageUrl'] ?? '',
      price: double.parse(documentSnapshot?['price'] ?? '0'),
      unit: documentSnapshot?['unit'] ?? '',
      rating: double.parse(documentSnapshot?['rating'] ?? '0'),
      reviews: int.parse(documentSnapshot?['reviews'] ?? '0'),
      isFavorite: documentSnapshot?['isFavorite'] ?? false,
      isPopular: documentSnapshot?['isPopular'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'unit': unit,
      'rating': rating,
      'reviews': reviews,
      'isFavorite': isFavorite,
      'isPopular': isPopular,
    };
  }
}
