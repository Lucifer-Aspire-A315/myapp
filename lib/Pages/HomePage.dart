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
              height: 10,
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
                Center(
                  child: CircleAvatar(
                    radius: 120,
                    child: Image.asset(
                      'assets/images/person1.png',
                    ),
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
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: 150,
                  child: Text(
                    'New Arrival',
                    style: TextStyle(
                      color: Colors.red.shade300,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      fontFamily: GoogleFonts.rampartOneTextTheme()
                          .bodyLarge
                          ?.fontFamily,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        child: Image.asset(
                          'assets/images/person1.png',
                        ),
                      ),
                      CircleAvatar(
                        radius: 35,
                        child: Image.asset(
                          'assets/images/person1.png',
                        ),
                      ),
                      CircleAvatar(
                        radius: 35,
                        child: Image.asset(
                          'assets/images/person1.png',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
