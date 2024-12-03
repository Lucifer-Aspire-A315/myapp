import 'package:flutter/material.dart';

// This class holds the cart count and notifies the UI when it changes
class CartProvider with ChangeNotifier {
  int _cartCount = 0; // Initial cart count
  int _wishcount=0;

  int get cartCount => _cartCount; // Getter for cart count
  int get wishlistcount=>_wishcount;

  void updateCartCount(int count) {
    _cartCount = count; // Update the count
    notifyListeners(); // Notify all widgets that are listening to this state
  }

  void updatewishlistCount(int count) {
    _wishcount = count; // Update the count
    notifyListeners(); // Notify all widgets that are listening to this state
  }
}
