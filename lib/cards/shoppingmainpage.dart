import 'package:flutter/material.dart';
import 'package:myapp/models/wishlist.dart';

import '../models/cloth.dart'; // Replace with the correct path to your ClothingItem model

class ItemDetailsPage extends StatefulWidget {
  final ClothingItem item;

  const ItemDetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late bool isInWishlist;
  String selectedSize = "S"; // Default selected size

  // Available and unavailable sizes
  final List<String> sizes = ["S", "M", "L", "XL", "2X", "3X", "4X"];
  final List<String> unavailableSizes = ["2X", "3X", "4X"];

  @override
  void initState() {
    super.initState();
    // Synchronize the state with WishlistManager
    isInWishlist = WishlistManager().wishlist.contains(widget.item);
  }

  void toggleWishlist() {
    if (isInWishlist) {
      WishlistManager().removeFromWishlist(widget.item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.item.name} removed from wishlist!'),
        ),
      );
    } else {
      WishlistManager().addToWishlist(widget.item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.item.name} added to wishlist!'),
        ),
      );
    }
    setState(() {
      // Synchronize the state
      isInWishlist = WishlistManager().wishlist.contains(widget.item);
    });
  }

  void showSizeGuide(BuildContext context) {
    // Display a dialog with size guide information
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Size Guide",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                "https://cdn.shopify.com/s/files/1/0598/8158/6848/files/Cropped_Leggings.jpg?v=1650445952123", // Replace with your actual image path
                height: 200,
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Here is a detailed guide to help you select the right size.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.item.name)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Stack(
                children: [
                  Center(
                    child: Image.network(
                      widget.item.imageUrl,
                      height: MediaQuery.sizeOf(context).height / 2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: toggleWishlist, // Toggle wishlist on press
                        icon: Icon(
                          Icons.favorite,
                          color: isInWishlist
                              ? Colors.red
                              : Colors.grey, // Change color based on state
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Name
              Text(
                widget.item.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Price
              Text(
                '₹${widget.item.price}',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Size Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "SIZE",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showSizeGuide(context); // Show size guide dialog
                    },
                    child: const Text(
                      "Size Guide",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: sizes.map((size) {
                  final isUnavailable = unavailableSizes.contains(size);
                  return GestureDetector(
                    onTap: isUnavailable
                        ? null
                        : () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedSize == size && !isUnavailable
                            ? Colors.black
                            : Colors.white,
                        border: Border.all(
                          color: isUnavailable
                              ? Colors.grey
                              : selectedSize == size
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: isUnavailable
                              ? Colors.grey
                              : selectedSize == size
                                  ? Colors.white
                                  : Colors.black,
                          decoration: isUnavailable
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              // Description
              Text(
                widget.item.description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
