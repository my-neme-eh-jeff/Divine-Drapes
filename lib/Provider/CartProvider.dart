import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  List<String> _addedProductsIds = [];

  List<String> get addedProductsIds => _addedProductsIds;

  void addToCart(String productId) {
    if (!_addedProductsIds.contains(productId)) {
      _addedProductsIds.add(productId);
      notifyListeners();
    }
  }

  void removeFromCart(String productId) {
    _addedProductsIds.remove(productId);
    notifyListeners();
  }
}
