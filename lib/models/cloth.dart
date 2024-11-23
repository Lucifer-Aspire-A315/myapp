class ClothingItem {
  final int id;
  final String imageUrl;
  final String name;
  final int price;
  final String description;

  ClothingItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
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
