class ClothingItem {
  late final int id;
  final String imageUrl;
  final String name;
  final int price;
  final String description;
  int quantity;

  ClothingItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
  });

  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    final dynamic idFromJson = json['id'] ?? json['itemId'];

    return ClothingItem(
        id: idFromJson,
        imageUrl: json['imageUrl'],
        name: json['name'],
        price: json['price'],
        description: json['description'] ?? "",
        quantity: json['quantity'] ?? 1);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClothingItem) return false;
    return id == other.id; // Compare based on a unique identifier
  }

  @override
  int get hashCode => id.hashCode; // Use the unique identifier for hashCode
}

//for wishlist api

class ClothingItem1 {
  final int id;
  final String imageUrl;
  final String name;
  final int price;
  final String description;

  ClothingItem1({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ClothingItem1.fromJson(Map<String, dynamic> json) {
    if (json['itemId'] == null) {
      throw Exception("itemId is null in JSON data: $json");
    }
    return ClothingItem1(
      id: json['itemId'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      price: json['price'],
      description: json['description'] ?? "",
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClothingItem) return false;
    return id == other.id; // Compare based on a unique identifier
  }

  @override
  int get hashCode => id.hashCode; // Use the unique identifier for hashCode
}
