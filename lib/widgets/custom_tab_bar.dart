import 'package:flutter/material.dart';
import 'dart:io';

class CustomTabBar extends StatefulWidget {
  final Function(int) onTabSelected;

  CustomTabBar({required this.onTabSelected});

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    double extraPadding = Platform.isIOS && topPadding > 30 ? 60 : 10;

    return Column(
      children: [
        ClipPath(
          clipper: TabBarClipper(), 
          child: Container(
            padding: EdgeInsets.only(top: extraPadding, left: 10, right: 10, bottom: 10),
            color: const Color.fromARGB(255, 255, 17, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTransparentButton(Icons.menu, onPressed: () {
                      widget.onTabSelected(0);
                    }),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red[900],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          _buildSelectableButton(
                            icon: Icons.flash_on,
                            text: "Ir Agora",
                            index: 1,
                          ),
                          _buildSelectableButton(
                            icon: Icons.calendar_today,
                            text: "Ir Outro Dia",
                            index: 2,
                          ),
                        ],
                      ),
                    ),

                    _buildTransparentButton(Icons.search, onPressed: () {
                      widget.onTabSelected(3);
                    }),
                  ],
                ),

                SizedBox(height: 10),

                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "São Paulo",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 22),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectableButton({required IconData icon, required String text, required int index}) {
    bool isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
        widget.onTabSelected(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.red[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isSelected ? const Color.fromARGB(255, 255, 0, 0) : Colors.white),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransparentButton(IconData icon, {required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(icon, size: 30, color: Colors.white),
      ),
    );
  }
}

class TabBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = 22; 
    Path path = Path();
    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(size.width * 0.25, size.height, size.width * 0.5, size.height);
    path.quadraticBezierTo(size.width * 0.75, size.height, size.width, size.height - curveHeight);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
