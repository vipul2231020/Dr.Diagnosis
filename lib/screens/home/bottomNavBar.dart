import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 80, color: Colors.white), // Optional background

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.blueAccent, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navIcon(Icons.home, 0),
                _navIcon(Icons.chat_bubble_outline, 1),
                _navIcon(Icons.person_outline, 2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _navIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        color: Colors.white.withOpacity(currentIndex == index ? 1.0 : 0.5),
        size: 28,
      ),
    );
  }
}
