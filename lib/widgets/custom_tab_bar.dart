import 'dart:io';
import 'package:flutter/material.dart';
import 'package:motel_guide/core/theme/app_theme.dart';

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
    double extraPadding = Platform.isIOS && topPadding > 30 ? 60 : 25;

    return Column(
      children: [
        ClipPath(
          clipper: TabBarClipper(),
          child: Container(
            padding: EdgeInsets.only(top: extraPadding, left: 10, right: 10, bottom: 5),
            color: AppTheme.primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Platform.isAndroid ? 5 : 0), 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTransparentButton(Icons.menu, onPressed: () {
                        widget.onTabSelected(0);
                      }),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryColor,
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
                ),
                SizedBox(height: 17),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "São Paulo",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.backgroundColor),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.keyboard_arrow_down, color: AppTheme.backgroundColor, size: 22),
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
          color: isSelected ? AppTheme.backgroundColor : AppTheme.secondaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isSelected ? AppTheme.primaryColor : AppTheme.backgroundColor),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : AppTheme.backgroundColor,
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
        child: Icon(icon, size: 30, color: AppTheme.backgroundColor),
      ),
    );
  }
}

class TabBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 25;

    Path path = Path();
    path.lineTo(0, size.height - radius);

    path.quadraticBezierTo(0, size.height, radius, size.height);

    path.lineTo(size.width - radius, size.height);

    path.quadraticBezierTo(size.width, size.height, size.width, size.height - radius);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
