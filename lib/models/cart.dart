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

  void addToCart(Map<String, dynamic> item) {
    int index =
        _cartItems.indexWhere((cartItem) => cartItem['id'] == item['id']);
    if (index != -1) {
      // If the item is already in the cart, update the quantity
      _cartItems[index]['quantity'] += item['quantity'];
    } else {
      // Add a new item to the cart
      _cartItems.add(item);
    }
  }

  // Remove item from cart
  void removeFromCart(Map<String, dynamic> item) {
    _cartItems.remove(item);
  }

  // Check if item exists in cart
  bool isInCart(int itemId) {
    return _cartItems.any((item) => item['itemId'] == itemId);
  }

  void updateItemQuantity(int itemId, int quantity) {
    int index = _cartItems.indexWhere((cartItem) => cartItem['id'] == itemId);
    if (index != -1) {
      _cartItems[index]['quantity'] = quantity;
    }
  }
}
