import 'package:flutter/material.dart';
import 'package:myapp/models/cart.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice(); // Initialize total price
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

  @override
  Widget build(BuildContext context) {
    final cartItems = CartManager().cartItems;

    return Scaffold(
      backgroundColor: Colors.white,
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
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'No items in the cart!',
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        print(item);
                        int quantity = item['quantity'] ?? 1;

                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row for Image and Details
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      item['imageUrl'],
                                      height: 120.0,
                                      width: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          '₹${item['price']}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        // Quantity Selector
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                if (quantity > 1) {
                                                  CartManager()
                                                      .updateItemQuantity(
                                                    item['id'],
                                                    quantity - 1,
                                                  );
                                                  _calculateTotalPrice();
                                                }
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 8.0,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              child: Text(
                                                '$quantity',
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                CartManager()
                                                    .updateItemQuantity(
                                                  item['id'],
                                                  quantity + 1,
                                                );
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
                              // Remove Button
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    CartManager().removeFromCart(item);
                                    _calculateTotalPrice(); // Update total price
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(microseconds: 1),
                                        content: Text(
                                            '${item['name']} removed from cart!'),
                                      ),
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
                ),
                // Total Price Section
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
            ),
    );
  }
}
