class ClothingItemWithImages {
  final int id;
  final String name;
  final double price;
  final String imageUrl; // First/main image
  final String description;
  final List<String> images; // All images

  ClothingItemWithImages({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.images,
  });

  factory ClothingItemWithImages.fromJson(Map<String, dynamic> json) {
    return ClothingItemWithImages(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      description: json['description'],
      images: List<String>.from(json['images']), // Convert to List<String>
    );
  }
}
