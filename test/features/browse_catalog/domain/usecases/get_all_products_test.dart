import 'package:dartz/dartz.dart';
import 'package:kokorico/features/browsing/domain/entities/product.dart';
import 'package:kokorico/features/browsing/domain/repositories/product_repository.dart';
import 'package:kokorico/features/browsing/domain/usescases/get_all_products.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  // GetAllProducts usecase;
  // MockProductRepository mockProductRepository;

  MockProductRepository mockProductRepository = MockProductRepository();
  GetAllProducts usecase = GetAllProducts(mockProductRepository);

  // setUp(() {
  //   MockProductRepository mockProductRepository = MockProductRepository();
  //   GetAllProducts usecase = GetAllProducts(mockProductRepository);
  // });

  String id = '1002';
  Product product = Product(
      id: id,
      name: 'Poulet',
      description: 'Poulet sur pied',
      imageUrl: 'imageUrl',
      price: 45,
      rating: 2,
      reviews: 45,
      isFavorite: true,
      isPopular: true);

  test('should get products from repository', () async {
    when(mockProductRepository.getProducts())
        .thenAnswer((_) async => await Right([]));

    final result = await usecase(id);

    expect(result, product);
    verify(mockProductRepository.getProducts());
  });
}
