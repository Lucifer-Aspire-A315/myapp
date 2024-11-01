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
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> products = [
    {
      'imagePath': 'assets/images/person1.png',
      'title': 'Stylish hat and beige jacket',
      'price': '\$19.99',
      'rating': 4.8,
      'ratingCount': 32,
      'isLocked': true,
    },
    {
      'imagePath': 'assets/images/person2.png',
      'title': 'Casual jacket with hoodie',
      'price': '\$25.50',
      'rating': 4.5,
      'ratingCount': 28,
      'isLocked': false,
    },
    {
      'imagePath': 'assets/images/person1.png',
      'title': 'Classic black leather jacket',
      'price': '\$99.99',
      'rating': 4.9,
      'ratingCount': 120,
      'isLocked': true,
    },
    {
      'imagePath': 'assets/images/person1.png',
      'title': 'Classic black leather jacket',
      'price': '\$9.99',
      'rating': 4.9,
      'ratingCount': 120,
      'isLocked': true,
    },
    // Add more products as needed
  ];

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredProducts = products;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    _searchController.dispose();
  }

  void _filterProducts(String keyword) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product['title'].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: GestureDetector(
          onTap: () {
            if (_isSearching) {
              setState(() {
                _isSearching = false;
                _searchController.clear();
                filteredProducts = products;
              });
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                        maxHeight: 70, maxWidth: double.infinity),
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: [
                        if (!_isSearching) ...[
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
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isSearching = true;
                              });
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                        if (_isSearching)
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 20, right: 15, left: 15),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () => {
                                      _filterProducts(_searchController.text)
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onTap: () => setState(() {
                                  _isSearching = true;
                                }),
                                // onChanged: (value) => _filterProducts(value),
                              ),
                            ),
                          ),
                      ],
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
                          child: ClipOval(
                            child: Image(
                              image: AssetImage('assets/images/second (1).jpg'),
                              width: 240, // Set diameter of the circle
                              height: 240,
                              fit: BoxFit
                                  .contain, // Ensures the image fits the circle fully
                            ),
                          ),
                        ),
                        Center(
                          child: ClipOval(
                            child: Image(
                              image: AssetImage('assets/images/second (2).jpg'),
                              width: 240,
                              height: 240,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Center(
                          child: ClipOval(
                            child: Image(
                              image: AssetImage('assets/images/second (3).jpg'),
                              width: 240,
                              height: 240,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 10), // Space between PageView and indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3, // Number of pages
                    effect: const ExpandingDotsEffect(
                      dotHeight: 5,
                      dotWidth: 5,
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
                                  foregroundImage: ResizeImage(
                                      AssetImage(
                                          'assets/images/second (1).jpg'),
                                      width: 100,
                                      height: 100,
                                      policy: ResizeImagePolicy.exact),
                                  radius: 35,
                                ),
                                CircleAvatar(
                                  foregroundImage: ResizeImage(
                                      AssetImage(
                                          'assets/images/second (1).jpg'),
                                      width: 100,
                                      height: 100,
                                      policy: ResizeImagePolicy.exact),
                                  radius: 35,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.lightBlueAccent,
                                  foregroundImage: ResizeImage(
                                      AssetImage(
                                          'assets/images/second (1).jpg'),
                                      width: 100,
                                      height: 100,
                                      policy: ResizeImagePolicy.exact),
                                  radius: 35,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  backgroundImage: ResizeImage(
                                      AssetImage(
                                          'assets/images/second (1).jpg'),
                                      width: 100,
                                      height: 100,
                                      policy: ResizeImagePolicy.exact),
                                  radius: 35,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.lightGreenAccent,
                                  foregroundImage: ResizeImage(
                                      AssetImage(
                                          'assets/images/second (1).jpg'),
                                      width: 100,
                                      height: 100,
                                      policy: ResizeImagePolicy.exact),
                                  radius: 35,
                                ),
                                CircleAvatar(
                                  backgroundImage: ResizeImage(
                                      AssetImage(
                                          'assets/images/second (1).jpg'),
                                      width: 100,
                                      height: 100,
                                      policy: ResizeImagePolicy.exact),
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
                      children: filteredProducts.map((product) {
                        return ProductCard(
                          imagePath: product['imagePath'],
                          title: product['title'],
                          price: product['price'],
                          rating: product['rating'],
                          ratingCount: product['ratingCount'],
                          isLocked: product['isLocked'],
                        );
                      }).toList()),
                ],
              ),
            ),
          ),
        ));
  }
}
