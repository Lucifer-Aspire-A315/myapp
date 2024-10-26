import 'package:flutter/material.dart';
import 'package:myapp/Pages/HomePage.dart';
import 'package:myapp/Pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Builder(
            builder: (BuildContext context) {
              // New Builder to provide a proper context
              return SizedBox(
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                            const Text('Liked', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/message.png',
                              width: 24,
                              height: 24,
                            ),
                            Text('Message', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
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
                            Text('Orders', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
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
                            Text('Profile', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
