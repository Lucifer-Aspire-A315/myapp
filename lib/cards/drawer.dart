import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool showSubMenu = false;
  String subMenuTitle = "";

  List<String> subMenuItems = [];

  void toggleSubMenu(String title, List<String> items) {
    setState(() {
      showSubMenu = true;
      subMenuTitle = title;
      subMenuItems = items;
    });
  }

  void goBack() {
    setState(() {
      showSubMenu = false;
      subMenuTitle = "";
      subMenuItems = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Login/Signup Header
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/photo.jpg', // Replace with your image asset
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Login / Signup',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Menu or Submenu
              Expanded(
                child: showSubMenu ? buildSubMenu() : buildMainMenu(),
              ),
            ],
          ),
          // Close Button Positioned on the Top Right
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMainMenu() {
    return ListView(
      children: [
        ListTile(
          title: Text('Women', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            toggleSubMenu("Women", [
              "Leggings & Churidar",
              "Ethnic Wear",
              "Palazzos",
              "Jeans & Jeggings",
              "Formal Wear"
            ]);
          },
        ),
        Divider(height: 1, color: Colors.grey[300]),
        ListTile(
          title: Text('Girls', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            toggleSubMenu("Girls",
                ["Tops & Tees", "Shorts", "Party Dresses", "Casual Wear"]);
          },
        ),
        Divider(height: 1, color: Colors.grey[300]),
        ListTile(
          title: Text('My Account'),
          onTap: () {
            // Navigate to My Account
          },
        ),
        Divider(height: 1, color: Colors.grey[300]),
        ListTile(
          title: Text('Returns and Exchanges'),
          onTap: () {
            // Navigate to Returns and Exchanges
          },
        ),
        Divider(height: 1, color: Colors.grey[300]),
        ListTile(
          title: Text('Get in Touch'),
          onTap: () {
            // Navigate to Get in Touch
          },
        ),
        Divider(height: 1, color: Colors.grey[300]),
        ListTile(
          title: Text('FAQs'),
          onTap: () {
            // Navigate to FAQs
          },
        ),
      ],
    );
  }

  Widget buildSubMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back Button
        ListTile(
          leading: Icon(Icons.arrow_back),
          title: Text(
            "Back",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: goBack,
        ),
        Divider(height: 1, color: Colors.grey[300]),

        // SubMenu Items
        Expanded(
          child: ListView.builder(
            itemCount: subMenuItems.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      subMenuItems[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Handle further submenu navigation if needed
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[300]),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
