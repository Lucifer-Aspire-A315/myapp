import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final String imageUrl;

  CategoryItem(this.label, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 75, // Adjusts the size of the outermost circle
            height: 75,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Background color of outermost circle
            ),
            child: Container(
              width: 70, // Adjusts the size of the middle border circle
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white, // Middle border color
                  width: 2.0, // Middle border width
                ),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 80, // Sets a fixed width to control text wrapping
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
