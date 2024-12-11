import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/countmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cloth.dart'; // Replace with your model path

class ItemDetailsPage extends StatefulWidget {
  final ClothingItem item;
  final int itemId;

  const ItemDetailsPage({Key? key, required this.item, required this.itemId})
      : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  bool isInWishlist = false;
  String selectedSize = "S"; // Default selected size
  late Future<List<dynamic>> _itemDetails;
  int quantity = 1;
  String email = '';
  String mobileNumber = '';
  String name = '';
  String dob = '';
  String mob = '';
  int id = 0;

  // Available and unavailable sizes
  final List<String> sizes = ["S", "M", "L", "XL", "2X", "3X", "4X"];
  final List<String> unavailableSizes = ["2X", "3X", "4X"];

  @override
  void initState() {
    super.initState();
    // Synchronize the state with WishlistManager
    // isInWishlist = WishlistManager().wishlist.contains(widget.item);
    _itemDetails = fetchItemImages(widget.itemId);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'Not Available';
      mobileNumber = prefs.getString('Mobileno') ?? 'Not Available';
      name = prefs.getString('firstname') ?? 'Not Available';
      dob = prefs.getString('dob') ?? 'Not Available';
      mob = prefs.getString('Mobileno') ?? 'Not Available';
      id = prefs.getInt('id') ?? 0;
    });
  }

  Future<List<dynamic>> fetchItemImages(int itemId) async {
    final response = await http.get(
      Uri.parse('http://192.168.1.35:5002/api/auth/clothing-item/$itemId'),
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
      throw Exception('Failed to load item details');
    }
  }

  void addToWishlist() async {
    final userId = id; // Replace with actual user ID
    final url = Uri.parse('http://192.168.1.35:5002/api/auth/add');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Id': userId,
        'itemId': widget.item.id,
        'name': widget.item.name,
        'price': widget.item.price,
        'imageUrl': widget.item.imageUrl,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final responseBody = jsonDecode(response.body);
      final updatedWishlistCount = responseBody['wishlist_count'];
      print(updatedWishlistCount);
      Provider.of<CartProvider>(context, listen: false)
          .updatewishlistCount(updatedWishlistCount);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.item.name} added to wishlist!'),
        ),
      );
      setState(() {
        isInWishlist = true;
      });
    } else {
      // Handle error
      final error = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  void addToCart() async {
    final userId = id; // Replace with actual user ID
    final url = Uri.parse('http://192.168.1.35:5002/api/auth/addcart');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Id': userId,
        'itemId': widget.item.id,
        'name': widget.item.name,
        'price': widget.item.price,
        'imageUrl': widget.item.imageUrl,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final responseBody = jsonDecode(response.body);
      final updatedcartCount = responseBody['cartCount'];
      print(updatedcartCount);
      Provider.of<CartProvider>(context, listen: false)
          .updateCartCount(updatedcartCount);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.item.name} added to cart!'),
        ),
      );
      setState(() {
        isInWishlist = true;
      });
    } else {
      // Handle error
      final error = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  // void toggleWishlist() {
  //   if (isInWishlist) {
  //     WishlistManager().removeFromWishlist(widget.item);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('${widget.item.name} removed from wishlist!'),
  //       ),
  //     );
  //   } else {
  //     WishlistManager().addToWishlist(widget.item);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('${widget.item.name} added to wishlist!'),
  //       ),
  //     );
  //   }
  //   setState(() {
  //     // Synchronize the state
  //     isInWishlist = WishlistManager().wishlist.contains(widget.item);
  //   });
  // }

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
      body: FutureBuilder<List<dynamic>>(
        future: _itemDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final images = snapshot.data!;
            return buildContent(context, images);
          } else {
            return const Center(child: Text('No images found'));
          }
        },
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildContent(BuildContext context, List<dynamic> images) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slideshow
            buildImageSlideshow(images),
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
                    showSizeGuide(context);
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
    );
  }

  Widget buildImageSlideshow(List<dynamic> images) {
    if (images.isEmpty) {
      // If the images list is empty, display a message
      return Center(
        child: Text(
          "No images are currently available",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      // If the images list has data, display the slideshow
      return Stack(
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index]["imageUrl"],
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () => {
                  addToWishlist(),
                },
                // Toggle wishlist on press
                icon: Icon(
                  Icons.favorite,
                  color: isInWishlist
                      ? Colors.red
                      : Colors.grey, // Change color based on state
                ),
              ),
            ),
          )
        ],
      );
    }
  }

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                icon: const Icon(Icons.remove, color: Colors.white),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
          // Add to Cart Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
            onPressed: () {
              addToCart();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ShoppingCartPage()),
              // );
            },
            child: const Text(
              "ADD TO CART",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
