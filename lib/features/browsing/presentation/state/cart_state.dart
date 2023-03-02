import '../../domain/entities/product.dart';
import 'auth_state.dart';

class CartState extends AuthState {
  /// This is the state of the cart
  List<Map<String, int>> _cart = [];

  /// This is the state of the favorites
  List<Map<String, int>> _favorites = [];

  /// Returns a list containing products in the cart
  List<Map<String, int>> get getCart => _cart;

  /// Returns a list containing products in the favorites
  List<Map<String, int>> get getFavorites => _favorites;

  /// Adds a product to the cart
  addCart(Map<String, int> cartRow) {
    _cart.add(cartRow);
    notifyListeners();
  }

  /// Adds a product to the favorites
  addFavorites(Map<String, int> favoritesRow) {
    _favorites.add(favoritesRow);
    notifyListeners();
  }

  init(List<Map<String, int>> cart, List<Map<String, int>> favorites) {
    _cart = cart;
    _favorites = favorites;
    notifyListeners();
  }

  /// Returns the quantity of a product in the cart
  int getQuantity(String id) {
    var quantity = 0;
    _cart.forEach((element) {
      if (element.keys.first == id) {
        quantity = element.values.first;
      }
    });
    return quantity;
  }

  /// Get the total price of the cart
  /// Returns a double
  /// Returns 0 if the cart is empty
  /// Returns the total price of the cart
  /// if the cart is not empty
  double getTotalPrice(List<Product> products) {
    var totalPrice = 0.0;
    if (_cart.isNotEmpty) {
      for (var element in _cart) {
        var id = element.keys.first;
        var quantity = element.values.first;
        var product = products.firstWhere((element) => element.id == id);
        totalPrice += product.price * quantity;
      }
    }
    return totalPrice;
  }

  /// Removes a product from the cart
}
