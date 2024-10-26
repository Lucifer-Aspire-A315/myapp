import 'package:flutter/material.dart';
import 'package:myapp/Pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red.shade100,
        body: const HomePage(), // Placeholder for your dashboard content
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 240, 240, 96),
          shape: const CircleBorder(),
          elevation: 5,
          onPressed: () {
            // Add action for the FAB
          },
          child: Image.asset(
            'assets/images/home-page.png',
            width: 24,
            height: 24,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          height: 65,
          color: Colors.red.shade200,
          // shadowColor: Colors.blueAccent,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 56, // Reduced height to fit content within BottomAppBar
            // padding: const EdgeInsets.symmetric(
            //     horizontal: 10.0), // Added padding for better spacing
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle Home tap
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/heart.png',
                          width: 24,
                          height: 24,
                        ),
                        const Text('Home', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                // Customers Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/message.png',
                          width: 24,
                          height: 24,
                        ),
                        Text('Search', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 40), // Space for the FloatingActionButton
                // Khata Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/bag.png',
                          width: 24,
                          height: 24,
                        ),
                        Text('Home', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                // Orders Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle Orders tap
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/user.png',
                          width: 24,
                          height: 24,
                        ),
                        Text('Home', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
