import 'package:flutter/material.dart';
import 'package:myapp/models/cloth.dart'; // Replace with the correct path to your ClothingItem model

class ClothingCard extends StatelessWidget {
  final ClothingItem item;

  const ClothingCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(12.0),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                // top: Radius.circular(12.0),
                ),
            child: Image.network(
              item.imageUrl,
              height: 180.0, // Fixed height for the image
              width: double.infinity, // Full width
              fit: BoxFit.cover, // Ensures image covers the available area
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis, // Ensures text doesn't overflow
                  ),
                  const SizedBox(height: 4.0),
                  // Price
                  Text(
                    '₹${item.price}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(), // Pushes description to the bottom
                  // Description
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow
                        .ellipsis, // Ensures text fits within the space
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
