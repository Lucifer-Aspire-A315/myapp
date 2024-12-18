import 'package:flutter/material.dart';
import 'package:myapp/Pages/gocolors1.dart';
import 'package:myapp/models/countmodel.dart';
import 'package:myapp/models/status.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => PageStatusProvider()),
      ],
      child: MyApp(),
    ),
  );
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

      // FutureBuilder<bool>(
      //     future: _checkLoginStatus(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return CircularProgressIndicator(); // or splash screen
      //       } else if (snapshot.hasData && snapshot.data == true) {
      //         return Home();
      //       } else {
      //         return LoginScreen();
      //       }
      //     },
      //   ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final Mobileno = prefs.getString('Mobileno');
    return Mobileno !=
        null; // Return true if token exists, meaning user is logged in
  }
}
