import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/cards/clothingCard.dart';

import '../models/cloth.dart'; // Import your model

// Import your fetch function

class ClothingListPage extends StatefulWidget {
  @override
  State<ClothingListPage> createState() => _ClothingListPageState();
}

class _ClothingListPageState extends State<ClothingListPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the number of items per row dynamically
    int crossAxisCount = screenWidth < 600
        ? 2
        : screenWidth < 1200
            ? 3
            : 4;

    double childAspectRatio = screenWidth < 600 ? 0.7 : 0.8;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Clothing Store')),
      ),
      body: FutureBuilder<List<ClothingItem>>(
        future: fetchClothingItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items found'));
          } else {
            final items = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.55,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ClothingCard(
                    item: items[index]); // Use the reusable widget
              },
            );
          }
        },
      ),
    );
  }
}

Future<List<ClothingItem>> fetchClothingItems() async {
  final response = await http
      .get(Uri.parse('http://192.168.1.39:5002/api/auth/clothing-item'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => ClothingItem.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load clothing items');
  }
}
