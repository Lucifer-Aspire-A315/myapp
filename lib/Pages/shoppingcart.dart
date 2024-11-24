// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/cloth.dart';

class ShoppingCartPage extends StatefulWidget {
  final int itemId;
  final ClothingItem? item;

  const ShoppingCartPage({
    Key? key,
    this.itemId = 0,
    this.item,
  }) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  int quantity = 2; // Initial quantity
  double price = 699.00; // Price of the item
  late Future<List<dynamic>> _itemDetails;

  @override
  void initState() {
    super.initState();
    _itemDetails = fetchItemImages(widget.itemId);
  }

  Future<List<dynamic>> fetchItemImages(int itemId) async {
    final response = await http.get(
      Uri.parse('http://192.168.1.38:5002/api/auth/clothing-item/$itemId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Check if the images list is empty
      if (data["images"].isEmpty) {
        print("no data");
        return []; // Return an empty list
      } else {
        print("data available");
        return data["images"];
      }
    } else {
      throw ('No item added ');
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = quantity * price;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Shopping Cart",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _itemDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final images = snapshot.data!;
            return buildContent(context, images, totalPrice);
          } else {
            return const Center(child: Text('No images found'));
          }
        },
      ),
    );
  }

  Widget buildContent(
      BuildContext context, List<dynamic> images, double totalPrice) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Item Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  images.isNotEmpty
                      ? images[0]
                          ["imageUrl"] // Use the first image URL dynamically
                      : "https://via.placeholder.com/80", // Placeholder image if no data
                  height: 180.0,
                  width: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item != null
                          ? widget.item!
                              .description // Safely use `item` if not null
                          : "No description available", // Fallback text
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "₹ $price",
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Quantity Selector
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            "$quantity",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Remove Button
                    TextButton(
                      onPressed: () {
                        // Remove item logic
                      },
                      child: const Text(
                        "Remove",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          // Total Price
          Column(
            children: [
              Divider(color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TOTAL:",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "₹ ${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[300]),
              // Coupon Text
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.green),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        "Coupon can be redeemed at checkout.",
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
