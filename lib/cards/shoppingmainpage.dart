import 'package:flutter/material.dart';
import '../models/cloth.dart'; // Replace with the correct path to your ClothingItem model

class ItemDetailsPage extends StatelessWidget {
  final ClothingItem item;

  const ItemDetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(item.name)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Center(
                child: Image.network(
                  item.imageUrl,
                  height: MediaQuery.sizeOf(context).height/2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              // Name
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Price
              Text(
                '₹${item.price}',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Description
              Text(
                item.description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16.0),
              // Additional details or buttons can go here
            ],
          ),
        ),
      ),
    );
  }
}
