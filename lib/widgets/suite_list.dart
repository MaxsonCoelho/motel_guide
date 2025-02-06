import 'package:flutter/material.dart';
import '../models/suite_model.dart';
import 'suite_item.dart';

class SuiteList extends StatelessWidget {
  final List<Suite> suites;

  SuiteList({required this.suites});

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(viewportFraction: 0.90);

    return Container(
      height: 350,
      child: PageView.builder(
        controller: _pageController,
        itemCount: suites.length,
        itemBuilder: (context, index) {
          return SuiteItem(suite: suites[index]);
        },
      ),
    );
  }
}
