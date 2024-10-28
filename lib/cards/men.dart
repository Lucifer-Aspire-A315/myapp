import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final double rating;
  final int ratingCount;
  final bool isLocked;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.rating,
    required this.ratingCount,
    this.isLocked = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.imagePath, // Use the dynamic image path
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title, // Dynamic title
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.price, // Dynamic price
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.rating.toString(), // Dynamic rating
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '(${widget.ratingCount} Ratings)', // Dynamic rating count
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Lock Icon
            if (widget.isLocked)
              Icon(
                Icons.lock_outline,
                color: Colors.grey.shade400,
              ),
          ],
        ),
      ),
    );
  }
}
