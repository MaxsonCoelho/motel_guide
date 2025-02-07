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
  PageController _pageController = PageController(viewportFraction: 0.90);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.67,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.suites.length,
        itemBuilder: (context, index) {
          Suite suite = widget.suites[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 0), 
            child: SingleChildScrollView( 
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  SuiteItem(suite: suite),

                  SizedBox(height: 10),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SuiteItemIcons(itens: suite.itens),
                  ),

                  SizedBox(height: 10),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SuitePricesList(periodos: suite.periodos),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
