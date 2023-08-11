import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List<String> _addedProductsIds = [];

  List<String> get addedProductsIds => _addedProductsIds;

  CartProvider() {
    // Load cart data during initialization
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList('cart_data');
    if (cartData != null) {
      _addedProductsIds = cartData;
      notifyListeners();
    }
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cart_data', _addedProductsIds);
    print('Saved Cart Details');
    Fluttertoast.showToast(
        msg: "Saved Cart Details",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void addToCart(String productId) {
    if (!_addedProductsIds.contains(productId)) {
      _addedProductsIds.add(productId);
      notifyListeners();
      saveCart(); // Call saveCart after modifying the cart
    }
  }

  void removeFromCart(String productId) {
    _addedProductsIds.remove(productId);
    notifyListeners();
    saveCart(); // Call saveCart after modifying the cart
  }
}
