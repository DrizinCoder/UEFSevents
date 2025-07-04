import 'package:flutter/material.dart';
import 'package:viveri/profile_page.dart';
import 'package:viveri/events/telas_criar_evento/create_favorite.dart';
import 'package:viveri/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavBar({Key? key, this.currentIndex = 0}) : super(key: key);

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
              _buildNavItemWithCircle(
                context: context,
                iconPath: 'assets/home.png',
                isActive: currentIndex == 0,
                onPressed: () {
                  if (currentIndex != 0) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                },
              ),
              _buildNavItemWithCircle(
                context: context,
                iconPath: 'assets/events.png',
                isActive: currentIndex == 1,
                onPressed: () {
                  if (currentIndex != 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateFavorite()),
                    );
                  }
                },
              ),
              _buildNavItemWithCircle(
                context: context,
                iconPath: 'assets/ticket.png',
                isActive: currentIndex == 2,
                onPressed: () {},
              ),
              _buildNavItemWithCircle(
                context: context,
                iconPath: 'assets/user.png',
                isActive: currentIndex == 3,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final userDataString = prefs.getString('user_data');
                  final accessToken = prefs.getString('access_token');
                  if (userDataString != null && accessToken != null) {
                    final userData = json.decode(userDataString);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          userData: userData,
                          accessToken: accessToken,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItemWithCircle({
    required BuildContext context,
    required String iconPath,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 55,
        height: 55,
        margin: EdgeInsets.only(bottom: isActive ? 25 : 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isActive)
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD4E0D4),
                ),
              ),
            if (isActive)
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF586C61),
                ),
              ),
            Image.asset(iconPath, width: 40, height: 40),
          ],
        ),
      ),
    );
  }

  // Outros ícones sem destaque de fundo
  Widget _buildNavItem({
    required String iconPath,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Image.asset(
          iconPath,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
} 