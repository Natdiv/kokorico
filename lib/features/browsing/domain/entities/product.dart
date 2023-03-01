import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String unit;
  final double rating;
  final bool isAvailable;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.unit,
    this.rating = 0,
    this.isAvailable = true,
  });

  set setId(String value) => id = value;

  @override
  List<Object> get props => [
        id!,
        name,
        description,
        imageUrl,
        price,
        unit,
        rating,
        isAvailable,
      ];
}
