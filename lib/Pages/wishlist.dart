import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/cards/shoppingmainpage.dart';
import 'package:myapp/models/cloth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistPage extends StatefulWidget {
  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  String email = '';
  String mobileNumber = '';
  String name = '';
  String dob = '';
  String mob = '';
  int id = 0;

  void initState() {
    super.initState();
    // Synchronize the state with WishlistManager
    // isInWishlist = WishlistManager().wishlist.contains(widget.item);

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

  Future<List<ClothingItem>> fetchWishlistItems() async {
    final userId =
        id; // Replace with the actual user ID or retrieve it dynamically
    final url = Uri.parse('http://192.168.1.10:5002/api/auth/user/$userId');

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

  void removeFromWishlist(ClothingItem item) async {
    if (id == null || id == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID is not available.'),
        ),
      );
      return;
    }
    final userId = id;
    final url = Uri.parse('http://192.168.1.10:5002/api/auth/remove');

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
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ClothingItem>>(
        future: fetchWishlistItems(),
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
                'No items in wishlist!',
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
              ),
            );
          } else {
            // If data is available, display the wishlist items
            final wishlist = snapshot.data!;
            return buildWishlistGrid(wishlist);
          }
        },
      ),
    );
  }

  Widget buildWishlistGrid(List<ClothingItem> wishlist) {
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
          return buildWishlistCard(item);
        },
      ),
    );
  }

  Widget buildWishlistCard(ClothingItem item) {
    return Card(
      shape: const RoundedRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailsPage(
                  itemId: item.id,
                  item: item,
                ),
              ),
            ),
            child: ClipRRect(
              child: Image.network(
                item.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
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
                  overflow: TextOverflow.ellipsis,
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
              ],
            ),
          ),
          const Spacer(),
          // Remove Button
          Center(
            child: TextButton(
              onPressed: () {
                removeFromWishlist(item);
              },
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
    );
  }
}
