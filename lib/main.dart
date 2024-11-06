import 'package:flutter/material.dart';
import 'package:myapp/Pages/gocolors1.dart';

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
      theme: ThemeData(canvasColor: Colors.white),
      home: Home(),
      // home: Scaffold(
      //   backgroundColor: Theme.of(context).canvasColor,
      //   body: const HomePage(), // Placeholder for your dashboard content
      //   floatingActionButton: FloatingActionButton(
      //     backgroundColor: const Color.fromARGB(255, 240, 240, 96),
      //     shape: const CircleBorder(),
      //     elevation: 5,
      //     onPressed: () {
      //       // Add action for the FAB
      //     },
      //     child: Image.asset(
      //       'assets/images/home-page.png',
      //       width: 24,
      //       height: 24,
      //     ),
      //   ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //   bottomNavigationBar: BottomAppBar(
      //     height: 65,
      //     color: Colors.yellow.shade700,
      //     shape: const CircularNotchedRectangle(),
      //     notchMargin: 8,
      //     child: Builder(
      //       builder: (BuildContext context) {
      //         // New Builder to provide a proper context
      //         return SizedBox(
      //           height: 56,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Expanded(
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     // Handle Home tap
      //                   },
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Image.asset(
      //                         'assets/images/heart.png',
      //                         width: 24,
      //                         height: 24,
      //                       ),
      //                       const Text('Liked', style: TextStyle(fontSize: 12)),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               Expanded(
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => const Login(),
      //                       ),
      //                     );
      //                   },
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Image.asset(
      //                         'assets/images/message.png',
      //                         width: 24,
      //                         height: 24,
      //                       ),
      //                       const Text('Message',
      //                           style: TextStyle(fontSize: 12)),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(width: 40),
      //               Expanded(
      //                 child: GestureDetector(
      //                   onTap: () {},
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Image.asset(
      //                         'assets/images/bag.png',
      //                         width: 24,
      //                         height: 24,
      //                       ),
      //                       const Text('Orders',
      //                           style: TextStyle(fontSize: 12)),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               Expanded(
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => const Signin(),
      //                       ),
      //                     );
      //                   },
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Image.asset(
      //                         'assets/images/user.png',
      //                         width: 24,
      //                         height: 24,
      //                       ),
      //                       const Text('Profile',
      //                           style: TextStyle(fontSize: 12)),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
