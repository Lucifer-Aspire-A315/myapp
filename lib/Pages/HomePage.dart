import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/cards/men.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false; // Variable to control search bar visibility
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(
                    maxHeight: 70, maxWidth: double.infinity),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.widgets_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.qr_code_scanner_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 20),
                    CircleAvatar(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _isSearching = !_isSearching; // Toggle search bar
                            });
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
              if (_isSearching)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width * 0.63,
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Center(
                      child: CircleAvatar(
                        radius: 120,
                        foregroundImage:
                            AssetImage('assets/images/second (1).jpg'),
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 120,
                        foregroundImage:
                            AssetImage('assets/images/second (2).jpg'),
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 120,
                        foregroundImage:
                            AssetImage('assets/images/second (3).jpg'),
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10), // Space between PageView and indicator
              SmoothPageIndicator(
                controller: _pageController,
                count: 3, // Number of pages
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.blueGrey,
                  dotColor: Colors.grey,
                ),
              ),
              const SizedBox(
                  height:
                      20), // Space between indicators and New Arrival section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      'New Arrival',
                      style: TextStyle(
                        color: Colors.red.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        fontFamily: GoogleFonts.rampartOneTextTheme()
                            .bodyLarge
                            ?.fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.63,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                              foregroundImage:
                                  AssetImage('assets/images/person1.png'),
                              radius: 35,
                            ),
                            CircleAvatar(
                              foregroundImage:
                                  AssetImage('assets/images/person2.png'),
                              radius: 35,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                              foregroundImage:
                                  AssetImage('assets/images/person1.png'),
                              radius: 35,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/person2.png'),
                              radius: 35,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.lightGreenAccent,
                              foregroundImage:
                                  AssetImage('assets/images/person1.png'),
                              radius: 35,
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/person2.png'),
                              radius: 35,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.yellow.shade600),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Men',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.yellow.shade600),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Women',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.yellow.shade600),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Children',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.yellow.shade600),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Formal',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.yellow.shade600),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Casual',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.yellow.shade600),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Stylish',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
        children: const [
          ProductCard(
            imagePath: 'assets/images/person1.png',
            title: 'Stylish hat and beige jacket',
            price: '\$19.99',
            rating: 4.8,
            ratingCount: 32,
            isLocked: true,
          ),
          ProductCard(
            imagePath: 'assets/images/person2.png',
            title: 'Casual jacket with hoodie',
            price: '\$25.50',
            rating: 4.5,
            ratingCount: 28,
            isLocked: false,
          ),
          ProductCard(
            imagePath: 'assets/images/person1.png',
            title: 'Classic black leather jacket',
            price: '\$99.99',
            rating: 4.9,
            ratingCount: 120,
            isLocked: true,
          ),
          // Add more ProductCard instances as needed
        ],
      ),
    
            ],
          ),
        ),
      ),
    );
  }
}
