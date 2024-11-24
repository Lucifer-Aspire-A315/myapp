import 'package:flutter/material.dart';
import 'package:myapp/cards/shoppingmainpage.dart';
import 'package:myapp/models/wishlist.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistManager().wishlist;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist'),
        centerTitle: true,
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text(
                'No items in wishlist!',
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width < 600
                      ? 2
                      : 3, // Adjust columns based on screen size
                  crossAxisSpacing: 5, // Space between columns
                  mainAxisSpacing: 5, // Space between rows
                  childAspectRatio: 0.55, // Adjust card height
                ),
                itemCount: wishlist.length,
                itemBuilder: (context, index) {
                  final item = wishlist[index];
                  return Card(
                    shape: const RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(8.0),
                        ),
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
                                    )),
                          ),
                          child: ClipRRect(
                            // borderRadius: BorderRadius.vertical(
                            //   top: Radius.circular(8.0),
                            // ),
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
                              WishlistManager().removeFromWishlist(item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${item.name} removed from wishlist!'),
                                ),
                              );
                              // Refresh the page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WishlistPage()),
                              );
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
                },
              ),
            ),
    );
  }
}
