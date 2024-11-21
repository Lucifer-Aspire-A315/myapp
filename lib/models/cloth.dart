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
}
