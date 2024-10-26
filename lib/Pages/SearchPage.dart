import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white60,
      //   title: const Text('Search Page'),
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
            Padding(
              padding: const EdgeInsets.all(10) ,
            
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for Casual Coords Women',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.camera_alt,
                      color: Color.fromARGB(255, 53, 48, 48)),
                  SizedBox(width: 8.0),
                  Icon(Icons.mic, color: Colors.grey),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
