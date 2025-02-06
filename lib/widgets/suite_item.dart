import 'package:flutter/material.dart';
import '../models/suite_model.dart';
import 'suite_item_icons.dart';

class SuiteItem extends StatelessWidget {
  final Suite suite;

  SuiteItem({required this.suite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  suite.fotos.first,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),

            
              SuiteItemIcons(itens: suite.itens),
            ],
          ),
        ),
      ),
    );
  }
}
