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
        body: const HomePage(), // Placeholder for your dashboard content
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey[900],
          shape: const CircleBorder(),
          elevation: 5,
          onPressed: () {
            // Add action for the FAB
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          height: 65,
          color: Colors.white,
          shadowColor: Colors.blueAccent,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Container(
            height: 56, // Reduced height to fit content within BottomAppBar
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0), // Added padding for better spacing
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle Home tap
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
                        Text('Home', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                // Customers Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle Customers tap
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
                        Text('Home', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 40), // Space for the FloatingActionButton
                // Khata Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
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
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
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
