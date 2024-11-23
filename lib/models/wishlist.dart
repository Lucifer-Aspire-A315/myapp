import 'package:myapp/models/cloth.dart';

class WishlistManager {
  static final WishlistManager _instance = WishlistManager._internal();

  factory WishlistManager() {
    return _instance;
  }

  WishlistManager._internal();

  final List<ClothingItem> _wishlist = [];

  List<ClothingItem> get wishlist => _wishlist;

  void addToWishlist(ClothingItem item) {
    if (!_wishlist.contains(item)) {
      _wishlist.add(item);
    }
  }

  void removeFromWishlist(ClothingItem item) {
    _wishlist.remove(item);
  }
}
