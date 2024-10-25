import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Myntra Search Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              const Text(
                'Myntra',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.black),
              Spacer(),
              // Flexible(
              //   child: Text(
              //     'BECOME INSIDER',
              //     style: TextStyle(
              //       color: Colors.amber[800],
              //       fontWeight: FontWeight.bold,
              //     ),
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              SizedBox(width: 10.0), // Spacing between elements
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:const  Row(
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
                    Icon(Icons.camera_alt, color: Color.fromARGB(255, 53, 48, 48)),
                    SizedBox(width: 8.0),
                    Icon(Icons.mic, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
