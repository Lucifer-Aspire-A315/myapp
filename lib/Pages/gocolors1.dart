import 'package:flutter/material.dart';
import 'package:myapp/Pages/Category.dart';
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
                  CategoryItem('Leggings & Churidar', "assets/images/th.jpg"),
                  CategoryItem('Ethnicwear', "assets/images/th.jpg"),
                  CategoryItem('Palazzos', "assets/images/th.jpg"),
                  CategoryItem('Casual Wear Lounge', "assets/images/th.jpg"),
                  CategoryItem('More', "assets/images/th.jpg"),
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
                    'assets/images/shopping.jpg', // Replace with your banner image path
                    width: double.infinity,
                    fit: BoxFit.cover,
                    
                  ),
                  Positioned(
                    top: 10,
                    left: 20,
                    child: Text(
                      'FESTIVE READY',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.pink[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: Text(
                      'WITH GO!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        // Define the action for the SHOP NOW button
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'SHOP NOW',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
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
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/shopping.jpg', // Replace with your banner image path
                    width: double.infinity,
                    fit: BoxFit.cover,
                    
                  ),
                  // Positioned(
                  //   top: 10,
                  //   left: 20,
                  //   child: Text(
                  //     'FESTIVE READY',
                  //     style: TextStyle(
                  //       fontSize: 24,
                  //       color: Colors.pink[600],
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 10,
                  //   right: 20,
                  //   child: Text(
                  //     'WITH GO!',
                  //     style: TextStyle(
                  //       fontSize: 24,
                  //       color: Colors.grey[800],
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   bottom: 20,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Define the action for the SHOP NOW button
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.black,
                  //     ),
                  //     child: const Text(
                  //       'SHOP NOW',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
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
              // const Divider(
              //   thickness: 2,
              //   color: Colors.black,
              //   indent: 50,
              //   endIndent: 50,
              // ),
              // Additional content such as products listing can go here
            ],
          ],
        ),
      ),
    );
  }
}
