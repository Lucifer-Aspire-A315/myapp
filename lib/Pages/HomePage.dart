// import 'package:flutter/material.dart';
// import 'package:myapp/Pages/SearchPage.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red.shade100,
//       // backgroundColor: const Color.fromARGB(77, 196, 130, 130),
//       // appBar: AppBar(
//       //   leading: IconButton(onPressed: () {}, icon: const Icon(Icons.widgets_outlined)),
//       //   title: const Text('Home Page'),
//       //   backgroundColor: Colors.white60,
//       //   actions: [
//       //     IconButton(
//       //       onPressed: () {
//       //         Navigator.push(
//       //           context,
//       //           MaterialPageRoute(
//       //             builder: (context) => const SearchPage(),
//       //           ),
//       //         );
//       //       },
//       //       icon: const Icon(Icons.shopping_bag_outlined),
//       //     ),
//       //     IconButton(
//       //       onPressed: () {},
//       //       icon: const Icon(Icons.favorite_border_outlined),
//       //     ),
//       //     IconButton(
//       //       onPressed: () {},
//       //       icon: const Icon(Icons.person_2_outlined),
//       //     ),
//       //   ],
//       // ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               // margin: const EdgeInsets.only(top: 25),
//               constraints: const BoxConstraints(
//                   maxHeight: 70, maxWidth: double.infinity),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.widgets_outlined,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                   ),
//                   // Text(
//                   //   'Categories',
//                   //   style: TextStyle(
//                   //     fontSize: 22,
//                   //     fontWeight: FontWeight.w900,
//                   //     fontStyle: GoogleFonts.playfairDisplayTextTheme()
//                   //         .bodyMedium
//                   //         ?.fontStyle,
//                   //   ),
//                   // ),
//                   const Spacer(),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.qr_code_scanner_outlined,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   CircleAvatar(
//                     child: Center(
//                       child: IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const SearchPage(),
//                               ),
//                             );
//                           },
//                           icon: const Icon(
//                             Icons.search,
//                             color: Colors.black,
//                             size: 30,
//                           )),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false; // Variable to control search bar visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      // backgroundColor: const Color.fromARGB(77, 196, 130, 130),
      // appBar: AppBar(
      //   leading: IconButton(onPressed: () {}, icon: const Icon(Icons.widgets_outlined)),
      //   title: const Text('Home Page'),
      //   backgroundColor: Colors.white60,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const SearchPage(),
      //           ),
      //         );
      //       },
      //       icon: const Icon(Icons.shopping_bag_outlined),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.favorite_border_outlined),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.person_2_outlined),
      //     ),
      //   ],
      // ),
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
              // Display search bar if _isSearching is true
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
              const SizedBox(
                height: 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 40,
                      )),
                  const Center(
                    child: CircleAvatar(
                      foregroundImage: AssetImage('assets/images/person1.png'),
                      backgroundColor: Colors.blueGrey,
                      radius: 120,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 40,
                      )),
                ],
              ),

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
              const SizedBox(
                height: 15,
              ),
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
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.yellow.shade600),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'All',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.yellow.shade600),
                            shape: WidgetStatePropertyAll(
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
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.yellow.shade600),
                            shape: WidgetStatePropertyAll(
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
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.yellow.shade600),
                            shape: WidgetStatePropertyAll(
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
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.yellow.shade600),
                            shape: WidgetStatePropertyAll(
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
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.yellow.shade600),
                            shape: WidgetStatePropertyAll(
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
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.yellow.shade600),
                            shape: WidgetStatePropertyAll(
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
