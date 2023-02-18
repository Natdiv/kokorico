import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviews;
  final bool isFavorite;
  final bool isPopular;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.isFavorite,
    required this.isPopular,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        rating,
        reviews,
        isFavorite,
        isPopular,
      ];
}
