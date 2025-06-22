import 'package:flutter/material.dart';
import 'package:viveri/profile_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Total height is 67px from the design. The bar is 50px, and the home button overlaps.
    return Container(
      height: 85, // Giving some extra space for the overlapping home button
      child: Stack(
        children: [
          // The main background bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 55,
              color: const Color(0xFF586C61),
            ),
          ),
          // A row for all the navigation items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildHomeButton(),
              _buildNavItem(iconPath: 'events.png', onPressed: () {}),
              _buildNavItem(iconPath: 'ticket.png', onPressed: () {}),
              _buildNavItem(
                iconPath: 'user.png',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Custom widget for the selected "Home" button
  Widget _buildHomeButton() {
    return Container(
      width: 55,
      height: 55,
      margin: const EdgeInsets.only(bottom: 15), // Lifts the button up a bit
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer circle
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD4E0D4),
            ),
          ),
          // Inner circle
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF586C61),
            ),
          ),
          // Icon
          Image.asset('home.png', width: 40, height: 40),
        ],
      ),
    );
  }

  // Widget for the other navigation items
  Widget _buildNavItem({required String iconPath, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Image.asset(iconPath, height: 30, width: 30),
      ),
    );
  }
} 