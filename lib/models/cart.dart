class CartManager {
  static final CartManager _instance = CartManager._internal();

  // Private constructor for singleton pattern
  CartManager._internal();

  factory CartManager() => _instance;

  // Cart items list
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  // Add item to cart
  void addItem(Map<String, dynamic> item) {
    _cartItems.add(item);
  }

  // Remove item from cart
  void removeItem(int itemId) {
    _cartItems.removeWhere((item) => item['itemId'] == itemId);
  }

  // Check if item exists in cart
  bool isInCart(int itemId) {
    return _cartItems.any((item) => item['itemId'] == itemId);
  }
}
