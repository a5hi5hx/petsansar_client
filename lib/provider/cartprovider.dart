import 'package:flutter/material.dart';
import '../exports.dart';



class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  int getTotalPrice() {
    int total = 0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
