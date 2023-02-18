import 'package:flutter_test/flutter_test.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';
import 'package:kokorico/features/browsing/domain/entities/product.dart';

void main() {
  final productModel = ProductModel(
    id: '1002',
    name: 'Poulet',
    description: 'Poulet sur pied',
    imageUrl: 'imageUrl',
    price: 45,
    rating: 2,
    reviews: 45,
    isFavorite: true,
    isPopular: true,
  );

  test('should be a subclass of Product entity', () {
    expect(productModel, isA<Product>());
  });
}
