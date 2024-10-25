// import 'package:flutter/material.dart';

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Myntra Search Bar',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: Row(
//             children: [
//               const Text(
//                 'Myntra',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Icon(Icons.arrow_drop_down, color: Colors.black),
//               const Spacer(),
//               // Flexible(
//               //   child: Text(
//               //     'BECOME INSIDER',
//               //     style: TextStyle(
//               //       color: Colors.amber[800],
//               //       fontWeight: FontWeight.bold,
//               //     ),
//               //     overflow: TextOverflow.ellipsis,
//               //   ),
//               // ),
//               const SizedBox(width: 10.0), // Spacing between elements
//               IconButton(
//                 icon: const Icon(Icons.notifications, color: Colors.black),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: const Icon(Icons.favorite_border, color: Colors.black),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: const Icon(Icons.person_outline, color: Colors.black),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.search, color: Colors.grey),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: 'Search for Casual Coords Women',
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     Icon(Icons.camera_alt,
//                         color: Color.fromARGB(255, 53, 48, 48)),
//                     SizedBox(width: 8.0),
//                     Icon(Icons.mic, color: Colors.grey),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_outlined)),
        title: const Text('Home Page'),
        backgroundColor: Colors.white60,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_2_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            constraints:
                const BoxConstraints(maxHeight: 70, maxWidth: double.infinity),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.category_outlined,
                    size: 35,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontStyle: GoogleFonts.playfairDisplayTextTheme()
                        .bodyMedium
                        ?.fontStyle,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
