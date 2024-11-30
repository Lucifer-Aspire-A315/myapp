import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/models/cart.dart';
import 'package:myapp/models/cloth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  int quantity=0;
  double totalPrice = 0.0;
  String email = '';
  String mobileNumber = '';
  String name = '';
  String dob = '';
  String mob = '';
  int id = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
    _loadUserData(); // Initialize total price
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

  void _calculateTotalPrice() {
    final cartItems = CartManager().cartItems;
    setState(() {
      totalPrice = cartItems.fold(
        0,
        (sum, item) => sum + (item['price'] * (item['quantity'] ?? 1)),
      );
    });
  }

  Future<List<ClothingItem>> fetchcartItems() async {
    final userId =
        id; // Replace with the actual user ID or retrieve it dynamically
    final url = Uri.parse('http://192.168.1.10:5002/api/auth/cartuser/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> items = data['data'];

      if (data['success'] && items.length >= 1) {
        print("response $items");

        return items.map((item) => ClothingItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch wishlist items: ');
      }
    } else {
      throw Exception('Failed to load wishlist items');
    }
  }

  void removeFromcart(ClothingItem item) async {
    if (id == null || id == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID is not available.'),
        ),
      );
      return;
    }
    final userId = id;
    final url = Uri.parse('http://192.168.1.10:5002/api/auth/removecart');

    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'itemId': item.id,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} removed from wishlist!'),
        ),
      );
      // Refresh the wishlist
      setState(() {});
    } else {
      final error = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('My Wishlist'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<ClothingItem>>(
          future: fetchcartItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the future is loading, show a loading indicator
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If an error occurred, display it
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // If the wishlist is empty, display a message
              return const Center(
                child: Text(
                  'No items in Cart!',
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
              );
            } else {
              // If data is available, display the wishlist items
              final wishlist = snapshot.data!;
              return buildcartGrid(wishlist);
            }
          },
        ));
  }

  Widget buildcartGrid(List<ClothingItem> wishlist) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 0.55,
        ),
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final item = wishlist[index];
          return buildcartCard(item,context);
        },
      ),
    );
  }

  Widget buildcartCard(ClothingItem item,BuildContext context) {
    // final cartItems = CartManager().cartItems;

    return  Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        item.imageUrl,
                        height: 120.0,
                        width: 80.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '₹${item.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // if (quantity > 1) {
                                  //   quantity--;
                                  //   _calculateTotalPrice();
                                  // }
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  item.id.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  quantity++;
                                  _calculateTotalPrice();
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: TextButton(
                    onPressed: () => removeFromcart(item),
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TOTAL:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[300]),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.green),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Coupon can be redeemed at checkout.',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  
  }
}
