import 'package:flutter/material.dart';
import 'package:myapp/Pages/Category.dart';
import 'package:myapp/Pages/clothing.dart';
import 'package:myapp/cards/shopbycolors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showColorsSection = false; // Control visibility of the colors section

  @override
  Widget build(BuildContext context) {
    // Get screen height to make widgets responsive
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('GO COLORS!', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 230, 221, 221),
                    ),
                    onPressed: () {
                      setState(() {
                        showColorsSection = true; // Show colors section
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/color-wheel.png', // Replace with your image path
                          width: 24, // Set image width
                          height: 24, // Set image height
                        ),
                        const SizedBox(
                            width: 8), // Space between image and text
                        const Text(
                          'SHOP BY COLOR',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: screenHeight * 0.15, // Increased height
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
                  CategoryItem('Loungewear',
                      "assets/images/Top_Scroll_Circle_Product_Icon-07.jpg"),
                  CategoryItem('Activewear',
                      "assets/images/Top_Scroll_Circle_Product_Icon-08.jpg"),
                  CategoryItem('Winterwear',
                      "assets/images/Top_Scroll_Circle_Product_Icon-09.jpg"),
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
                height: screenHeight - appBarHeight - 200, // Responsive height
                child: ShopByColors(),
              )
            else ...[
              // "FESTIVE READY" Banner and other content go here
              const SizedBox(height: 0),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/Festive-with-Go-Banner_Mobile_414x650.jpg', // Replace with your banner image path
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  //
                ],
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
                    CategoryItem('Dark pink', "assets/colors/dark_pink.png"),
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
            ],
          ],
        ),
      ),
    );
  }
}
