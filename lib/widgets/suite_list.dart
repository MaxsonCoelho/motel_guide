import 'package:flutter/material.dart';
import '../models/suite_model.dart';
import 'suite_item.dart';
import 'suite_item_icons.dart';
import 'suite_prices_list.dart';

class SuiteList extends StatelessWidget {
  final List<Suite> suites;

  SuiteList({required this.suites});

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(viewportFraction: 0.90);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 280, 
          child: PageView.builder(
            controller: _pageController,
            itemCount: suites.length,
            itemBuilder: (context, index) {
              return SuiteItem(suite: suites[index]);
            },
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4), 
          child: SuiteItemIcons(itens: suites.first.itens),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30), 
          child: SuitePricesList(periodos: suites.first.periodos),
        ),
      ],
    );
  }
}
