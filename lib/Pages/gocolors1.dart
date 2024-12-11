import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/Category.dart';
import 'package:myapp/Pages/account.dart';
import 'package:myapp/Pages/clothing.dart';
import 'package:myapp/Pages/shoppingcart.dart';
import 'package:myapp/Pages/wishlist.dart';
import 'package:myapp/cards/clothingCard.dart';
import 'package:myapp/cards/drawer.dart';
import 'package:myapp/cards/shopbycolors.dart';
import 'package:myapp/models/cloth.dart';
import 'package:myapp/models/countmodel.dart';
import 'package:myapp/signin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showColorsSection = false; // Control visibility of the colors section
  final List<String> _slideshowImages = [
    'assets/images/Festive-with-Go-Banner_Mobile_414x650.jpg',
    'assets/images/Wedding-styles-Mobile_414x650.jpg',
    'assets/images/Winter-wear-styles-Mobile_414x650.jpg',
  ];

  bool isLoggedIn = false; // Track login state

  int _currentPage = 0;
  late final PageController _pageController;

  late final Timer _slideshowTimer;

  List<ClothingItem> items = [];
  bool isSearching = false;
  String email = '';
  String mobileNumber = '';
  String name = '';
  String dob = '';
  String mob = '';
  int id = 0;
  int cartcount = 0;
  int wishcount = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _checkLoginStatus();

    setState(() {
      numbers();
    });

    // Timer for automatic slideshow
    _slideshowTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        // Check if the PageController is attached
        setState(() {
          if (_currentPage < _slideshowImages.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        });
      }
    });
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id') ?? 0; // Retrieve 'id'
      print("Loaded ID: $id"); // Debug to check if ID is loaded
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the PageController
    _slideshowTimer.cancel(); // Cancel the Timer to avoid memory leaks
    super.dispose();
  }

  Future<void> clearAllSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("All SharedPreferences data cleared.");
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  Future<void> _loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    setState(() {
      isLoggedIn = true;
    });
  }

  Future<void> _logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
    });
  }

  Future<void> fetchnumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
    });
  }

  Future<void> numbers() async {
    await _loadUserData();
    final url = Uri.parse("http://192.168.1.35:5002/api/auth/counts/$id");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        cartcount = data['data']['cartitems_count'];
        Provider.of<CartProvider>(context, listen: false)
            .updateCartCount(cartcount);
        print(cartcount);
        wishcount = data['data']['wishlist_count'];
        Provider.of<CartProvider>(context, listen: false)
            .updatewishlistCount(wishcount);
        // final List<dynamic> jsonData =
        //     json.decode(response.body); // Decode the JSON response
        // final List<dynamic> data =jsonData;
        // print(data); // Print the parsed items
        // setState(() {
        //   items = data; // Update the items state variable
        // });
      } else {
        throw Exception("Failed to fetch items");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchitems(String query) async {
    final url =
        Uri.parse("http://192.168.1.35:5002/api/auth/items?search=$query");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(response.body); // Decode the JSON response
        final List<ClothingItem> data = jsonData
            .map((json) =>
                ClothingItem.fromJson(json)) // Map each item to ClothingItem
            .toList();
        print(data); // Print the parsed items
        setState(() {
          items = data; // Update the items state variable
        });
      } else {
        throw Exception("Failed to fetch items");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height to make widgets responsive
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the number of items per row dynamically
    int crossAxisCount = screenWidth < 600
        ? 2
        : screenWidth < 1200
            ? 3
            : 4;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo.webp",
            width: 150,
          ),

          // const Text('GO COLORS!', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Center(
              child: PopupMenuButton<String>(
                icon: Image.asset(
                  "assets/images/user.png",
                  height: 30,
                ),
                onSelected: (value) {
                  if (value == 'logout') {
                    _logoutUser();
                  } else if (value == 'login') {
                    _loginUser();
                  } else {
                    print("$value selected");
                  }
                },
                itemBuilder: (BuildContext context) {
                  if (isLoggedIn) {
                    // Show logged-in menu
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'my_account',
                        child: Text('MY ACCOUNT'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyAccountPage()),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'wishlist',
                        child: Text('WISHLIST'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishlistPage()),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'logout',
                        child: Text('LOGOUT'),
                        onTap: () => clearAllSharedPreferences(),
                      ),
                    ];
                  } else {
                    // Show first-time user menu
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'login',
                        child: Text('LOGIN/ SIGN UP'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'wishlist',
                        child: Text('WISHLIST'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishlistPage()),
                        ),
                      ),
                    ];
                  }
                },
              ),
            ),
            Stack(
              children: [
                Positioned(
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Text(
                        "${cartProvider.wishlistcount}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  top: 15,
                  left: 20,
                ),
                IconButton(
                  icon: Image.asset(
                    "assets/images/heart.png",
                    height: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistPage(),
                      ),
                    ).then((_) {
                      numbers(); // Refresh the cart count when returning
                    });
                  },
                ),
              ],
            ),
            Stack(
              children: [
                Positioned(
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Text(
                        "${cartProvider.cartCount}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  top: 18,
                  left: 20,
                ),
                IconButton(
                  icon: Image.asset(
                    "assets/images/shopping-bag.png",
                    height: 30,
                  ),
                  // icon: const Icon(
                  //   Icons.shopping_cart_outlined,
                  //   color: Colors.black,
                  //   size: 30,
                  // ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingCartPage(),
                      ),
                    ).then((_) {
                      numbers(); // Refresh the cart count when returning
                    });

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ShoppingCartPage()),
                    // );
                  },
                ),
              ],
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Your search field, button, and categories list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: (query) {
                    if (query.isNotEmpty) {
                      fetchitems(query);
                      setState(() {
                        isSearching = true;
                      });
                    } else {
                      setState(() {
                        isSearching = false;
                      });
                    }
                  }),
            ),
            if (isSearching)
              items.isEmpty
                  ? Center(child: Text("No results found"))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.8, // Constrain height
                      child: GridView.builder(
                        shrinkWrap:
                            true, // Allows GridView to take only needed space
                        // physics:
                        //     const NeverScrollableScrollPhysics(), // Prevent inner scrolling
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.55,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final clothingItem = items[index];
                          return ClothingCard(
                            item: clothingItem,
                          );
                        },
                      ),
                    )
            else ...[
              Column(
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 230, 221, 221),
                        ),
                        onPressed: () {
                          setState(() {
                            showColorsSection = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/color-wheel.png',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'SHOP BY COLOR',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: screenHeight * 0.15,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          child: CategoryItem('Leggings & Churidar',
                              "assets/images/Top_Scroll_Circle_Product_Icon-01.jpg"),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClothingListPage()),
                          ),
                        ),
                        CategoryItem('Ethnicwear',
                            "assets/images/Top_Scroll_Circle_Product_Icon-02.jpg"),
                        CategoryItem('Casualwear Lounge',
                            "assets/images/Top_Scroll_Circle_Product_Icon-04.jpg"),
                        CategoryItem('Jeans & Jeggings',
                            "assets/images/Top_Scroll_Circle_Product_Icon-05.jpg"),
                        CategoryItem('Formalwear',
                            "assets/images/Top_Scroll_Circle_Product_Icon-06.jpg"),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showColorsSection = false; // Hide colors section
                          });
                        },
                        child: const Text(
                          "Home",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Shop By Colors",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Conditionally display the ShopByColors section or other content
                  if (showColorsSection)
                    SizedBox(
                      height: screenHeight -
                          appBarHeight -
                          200, // Responsive height
                      child: ShopByColors(),
                    )
                  else ...[
                    // "FESTIVE READY" Banner and other content go here
                    const SizedBox(height: 0),
                    SizedBox(
                      height:
                          screenHeight * 0.7, // Adjust height for the slideshow
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _slideshowImages.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            _slideshowImages[index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'TRENDING BOTTOMWEAR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black,
                      indent: 50,
                      endIndent: 50,
                    ),
                    const SizedBox(height: 40),
                    Stack(
                      children: [
                        // Background Image
                        Image.asset(
                          'assets/images/Trending-Now-Banner_Mobile_414x650.jpg', // Replace with your image path
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        // Center Aligned Text
                        Positioned(
                          top: screenHeight / 4.5,
                          left: 10,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'ANKLE LENGTH LEGGINGS',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'KURTI PANTS',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'CHURIDAR',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'SHIMMER LEGGINGS',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'COTTON PANTS',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'MUST HAVES',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Must-Have_Mobile_414x600.jpg', // Replace with your banner image path
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        //
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'TRENDING COLORS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      height: screenHeight * 0.15, // Increased height
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CategoryItem('beige', "assets/colors/beige.png"),
                          CategoryItem(
                              'Dark pink', "assets/colors/dark_pink.png"),
                          CategoryItem('Grey', "assets/colors/Grey.png"),
                          CategoryItem('Mustard', "assets/colors/Mustard.png"),
                          CategoryItem(
                              'Ocean Green', "assets/colors/Ocean_green.png"),
                          CategoryItem(
                              'Olive Green', "assets/colors/olive_green.png"),
                          CategoryItem('Purple', "assets/colors/purple.png"),
                          CategoryItem('Red',
                              "assets/colors/red_c9bdc17f-6089-4d31-a837-92f7b606d99a.png"),
                          CategoryItem('Rust',
                              "assets/colors/rust_4444a6bd-ea5d-4e61-a59c-b3e3cdb6a336.png"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Center(
                      child: Text(
                        'GO EDITS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                      child: Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClothingListPage()),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Image.asset(
                                  //   'assets/images/Go-Edits-1_d85b6771-00fb-45c1-abcd-17ad1e608fd9.jpg', // Replace with your banner image path
                                  //   width: double.infinity,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Image.network(
                                    "https://gocolors.com/cdn/shop/files/Go-Edits-1_d85b6771-00fb-45c1-abcd-17ad1e608fd9.jpg?v=1732013386",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClothingListPage()),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    "https://gocolors.com/cdn/shop/files/Go-Edits-2_6e6f5fbc-ba00-4821-86f2-57eac9006ea9.jpg?v=1732013386",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                  //
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClothingListPage()),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    "https://gocolors.com/cdn/shop/files/Go-Edits-3_6ee77b16-12b4-4078-b001-af01f68a0d4d.jpg?v=1732013386",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                  //
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ],
              ),
            ]
          ]),
        ));
  }
}
