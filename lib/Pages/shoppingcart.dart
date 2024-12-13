// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:myapp/models/cloth.dart';
// import 'package:myapp/models/status.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ShoppingCartPage extends StatefulWidget {
//   @override
//   _ShoppingCartPageState createState() => _ShoppingCartPageState();
// }

// class _ShoppingCartPageState extends State<ShoppingCartPage> {
//   int quantity = 0; // Default quantity as per the image
//   double totalPrice = 0.0;
//   String email = '';
//   String mobileNumber = '';
//   String name = '';
//   String dob = '';
//   int id = 0;
//   late Future<List<ClothingItem>> cartItemsFuture;
//   List<ClothingItem> cartItems = [];

//   @override
//   void initState() {
//     super.initState();
//     cartItemsFuture = Future.value([]);
//     _loadUserDataAndFetchCartItems();
//     // _calculateTotalPrice();
//     // fetchCartItems();
//   }

//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       email = prefs.getString('email') ?? 'Not Available';
//       mobileNumber = prefs.getString('Mobileno') ?? 'Not Available';
//       name = prefs.getString('firstname') ?? 'Not Available';
//       dob = prefs.getString('dob') ?? 'Not Available';
//       id = prefs.getInt('id') ?? 0;
//     });
//   }

//   Future<void> _loadUserDataAndFetchCartItems() async {
//     await _loadUserData(); // Wait for user data to load
//     setState(() {
//       cartItemsFuture =
//           fetchCartItems(); // Call the API after loading user data
//     });
//   }

//   // void _calculateTotalPrice() {
//   void _calculateTotalPrice() {
//     setState(() {
//       totalPrice = cartItems.fold(
//         0.0,
//         (sum, item) => sum + (item.price * item.quantity),
//       );
//     });
//   }

//   Future<List<ClothingItem>> fetchCartItems() async {
//     final url = Uri.parse('http://192.168.1.35:5002/api/auth/cartuser/$id');

//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List<dynamic> items = data['data'];
//       final fetchedItems =
//           items.map((item) => ClothingItem.fromJson(item)).toList();

//       if (data['success'] && items.isNotEmpty) {
//         setState(() {
//           cartItems = fetchedItems;
//           _calculateTotalPrice(); // Calculate the total price after loading cart
//         });

//         return fetchedItems;
//       } else {
//         throw Exception('No items found in the cart.');
//       }
//     } else {
//       throw Exception('Failed to fetch cart items');
//     }
//   }

//   void removeFromCart(ClothingItem item) async {
//     final url = Uri.parse('http://192.168.1.35:5002/api/auth/removecart');

//     final response = await http.delete(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'userId': id,
//         'itemId': item.id,
//       }),
//     );

//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('${item.name} removed from cart!')),
//       );
//       setState(() {
//         cartItems.remove(item);
//         _calculateTotalPrice();
//       });
//     } else {
//       final error = jsonDecode(response.body)['message'];
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $error')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Shopping Cart'),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<ClothingItem>>(
//         future: cartItemsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No items in Cart!',
//                 style: TextStyle(fontSize: 18.0, color: Colors.black54),
//               ),
//             );
//           } else {
//             return buildCart(snapshot.data!);
//           }
//         },
//       ),
//     );
//   }

//   Widget buildCart(List<ClothingItem> cartItems) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ...cartItems.map((item) => buildCartItem(item)).toList(),
//             const Divider(color: Colors.grey),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'TOTAL:',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '₹${totalPrice.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(color: Colors.grey),
//             Row(
//               children: const [
//                 Icon(Icons.card_giftcard, color: Colors.green),
//                 SizedBox(width: 8.0),
//                 Expanded(
//                   child: Text(
//                     'Coupon can be redeemed at checkout.',
//                     style: TextStyle(fontSize: 14.0, color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCartItem(ClothingItem item) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: Image.network(
//               item.imageUrl,
//               height: 100.0,
//               width: 80.0,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 16.0),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 8.0),
//                 Text(
//                   '₹${item.price.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         if (item.quantity > 1) {
//                           setState(() {
//                             item.quantity--;
//                             _calculateTotalPrice(); // Recalculate total price
//                           });
//                         }
//                       },
//                       icon: const Icon(Icons.remove),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16.0,
//                         vertical: 8.0,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(4.0),
//                       ),
//                       child: Text(
//                         '${item.quantity}', // Display item's quantity
//                         style: const TextStyle(
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           item.quantity++;
//                           _calculateTotalPrice(); // Recalculate total price
//                         });
//                       },
//                       icon: const Icon(Icons.add),
//                     ),
//                   ],
//                 ),
//                 TextButton(
//                   onPressed: () => setState(() {
//                     removeFromCart(item);
//                   }),
//                   child: const Text(
//                     'Remove',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/address.dart';
import 'package:myapp/Pages/progressindicator.dart';
import 'package:myapp/models/cloth.dart';
import 'package:myapp/models/status.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Address Page

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  int quantity = 0; // Default quantity as per the image
  double totalPrice = 0.0;
  String email = '';
  String mobileNumber = '';
  String name = '';
  String dob = '';
  int id = 0;
  late Future<List<ClothingItem>> cartItemsFuture;
  List<ClothingItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItemsFuture = Future.value([]);
    _loadUserDataAndFetchCartItems();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'Not Available';
      mobileNumber = prefs.getString('Mobileno') ?? 'Not Available';
      name = prefs.getString('firstname') ?? 'Not Available';
      dob = prefs.getString('dob') ?? 'Not Available';
      id = prefs.getInt('id') ?? 0;
    });
  }

  Future<void> _loadUserDataAndFetchCartItems() async {
    await _loadUserData(); // Wait for user data to load
    setState(() {
      cartItemsFuture =
          fetchCartItems(); // Call the API after loading user data
    });
  }

  void _calculateTotalPrice() {
    setState(() {
      totalPrice = cartItems.fold(
        0.0,
        (sum, item) => sum + (item.price * item.quantity),
      );
    });
  }

  Future<List<ClothingItem>> fetchCartItems() async {
    final url = Uri.parse('http://192.168.1.35:5002/api/auth/cartuser/$id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> items = data['data'];
      final fetchedItems =
          items.map((item) => ClothingItem.fromJson(item)).toList();

      if (data['success'] && items.isNotEmpty) {
        setState(() {
          cartItems = fetchedItems;
          _calculateTotalPrice(); // Calculate the total price after loading cart
        });

        return fetchedItems;
      } else {
        throw Exception('No items found in the cart.');
      }
    } else {
      throw Exception('Failed to fetch cart items');
    }
  }

  void removeFromCart(ClothingItem item) async {
    final url = Uri.parse('http://192.168.1.35:5002/api/auth/removecart');

    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': id,
        'itemId': item.id,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.name} removed from cart!')),
      );
      setState(() {
        cartItems.remove(item);
        _calculateTotalPrice();
      });
    } else {
      final error = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageStatus = Provider.of<PageStatusProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Shopping Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Decrement step and navigate back
            Provider.of<PageStatusProvider>(context, listen: false)
                .updateStep(1); // Decrement step by 1
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Step Progress Indicator
          StepProgressIndicator(currentStep: pageStatus.currentStep),
          Expanded(
            child: FutureBuilder<List<ClothingItem>>(
              future: cartItemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No items in Cart!',
                      style: TextStyle(fontSize: 18.0, color: Colors.black54),
                    ),
                  );
                } else {
                  return buildCart(snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Provider.of<PageStatusProvider>(context, listen: false)
              .updateStep(2); // Navigate to Address step
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  Address(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                final tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        },
        child: const Text('Add Address'),
      ),
      // isExtended: true,
    );
  }

  Widget buildCart(List<ClothingItem> cartItems) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...cartItems.map((item) => buildCartItem(item)).toList(),
            const Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
            const Divider(color: Colors.grey),
            Row(
              children: const [
                Icon(Icons.card_giftcard, color: Colors.green),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Coupon can be redeemed at checkout.',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Provider.of<PageStatusProvider>(context, listen: false)
            //         .updateStep(2); // Navigate to Address step
            //     Navigator.push(
            //       context,
            //       PageRouteBuilder(
            //         pageBuilder: (context, animation, secondaryAnimation) =>
            //             Address(),
            //         transitionsBuilder:
            //             (context, animation, secondaryAnimation, child) {
            //           const begin = Offset(1.0, 0.0);
            //           const end = Offset.zero;
            //           const curve = Curves.easeInOut;

            //           final tween = Tween(begin: begin, end: end)
            //               .chain(CurveTween(curve: curve));
            //           final offsetAnimation = animation.drive(tween);

            //           return SlideTransition(
            //               position: offsetAnimation, child: child);
            //         },
            //       ),
            //     );
            //   },
            //   child: const Text('Add Address'),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(ClothingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              item.imageUrl,
              height: 100.0,
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
                        if (item.quantity > 1) {
                          setState(() {
                            item.quantity--;
                            _calculateTotalPrice(); // Recalculate total price
                          });
                        }
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
                        '${item.quantity}', // Display item's quantity
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          item.quantity++;
                          _calculateTotalPrice(); // Recalculate total price
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => setState(() {
                    removeFromCart(item);
                  }),
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
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
