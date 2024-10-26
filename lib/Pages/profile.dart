import 'package:flutter/material.dart';

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The CircleAvatar for the profile image
          CircleAvatar(
            radius: 100, // Adjust size as needed
            backgroundImage: AssetImage(
                'assets/images/message.png'), // Replace with your image path
          ),
          // Positioned Arrows for navigation
          Positioned(
            left: 10, // Positioned slightly outside the circle
            child: IconButton(
              onPressed: () {
                // Handle previous action
              },
              icon: const Icon(Icons.arrow_back,
                  size: 30), // Increase icon size for visibility
              color: Colors.black,
            ),
          ),
          Positioned(
            right: 10, // Positioned slightly outside the circle
            child: IconButton(
              onPressed: () {
                // Handle next action
              },
              icon: const Icon(Icons.arrow_forward,
                  size: 30), // Increase icon size for visibility
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
