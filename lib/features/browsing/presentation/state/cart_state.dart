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
    (_cart.contains(cartRow))
        ? _cart[_cart.indexOf(cartRow)]
            .update(cartRow.keys.first, (value) => value + 1)
        : _cart.add(cartRow);
    notifyListeners();
  }

  /// Update a product quantity in the cart
  updateCart(String id, int quantity) {
    for (var i = 0; i < _cart.length; i++) {
      if (_cart[i].keys.first == id) {
        _cart[i].update(id, (value) => quantity);
      }
    }
    notifyListeners();
  }

  /// Checks if a product is in the cart
  bool isInCart(String id) {
    var isInCart = false;
    for (var element in _cart) {
      if (element.keys.first == id) {
        isInCart = true;
      }
    }
    return isInCart;
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
    for (var element in _cart) {
      if (element.keys.first == id) {
        quantity = element.values.first;
        return quantity;
      }
    }
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
  void removeFromCart(String s) {
    _cart.removeWhere((element) => element.keys.first == s);
    notifyListeners();
  }
}
