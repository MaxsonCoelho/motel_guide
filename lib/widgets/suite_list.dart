import 'package:flutter/material.dart';
import '../models/suite_model.dart';
import 'suite_item.dart';
import 'suite_item_icons.dart';
import 'suite_prices_list.dart';

class SuiteList extends StatefulWidget {
  final List<Suite> suites;

  SuiteList({required this.suites});

  @override
  _SuiteListState createState() => _SuiteListState();
}

class _SuiteListState extends State<SuiteList> {
  int _currentIndex = 0; 
  PageController _pageController = PageController(viewportFraction: 0.90);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 280, 
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.suites.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index; 
              });
            },
            itemBuilder: (context, index) {
              return SuiteItem(suite: widget.suites[index]);
            },
          ),
        ),

        SizedBox(height: 8), 

        AnimatedSwitcher(
          duration: Duration(milliseconds: 300), 
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Padding(
            key: ValueKey(_currentIndex), 
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4), 
            child: SuiteItemIcons(itens: widget.suites[_currentIndex].itens),
          ),
        ),

        SizedBox(height: 8), 

        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Padding(
            key: ValueKey(_currentIndex), 
            padding: EdgeInsets.symmetric(horizontal: 30), 
            child: SuitePricesList(periodos: widget.suites[_currentIndex].periodos),
          ),
        ),
      ],
    );
  }
}
