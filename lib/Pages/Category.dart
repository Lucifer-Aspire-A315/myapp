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
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(imageUrl),
          ),
          SizedBox(height: 8),
          Container(
            width: 80, // Sets a fixed width to control text wrapping
            child: Text(
              label,
              style:const  TextStyle(fontSize: 12,fontWeight: FontWeight.w700),
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
