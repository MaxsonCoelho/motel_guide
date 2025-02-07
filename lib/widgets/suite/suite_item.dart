import 'package:flutter/material.dart';
import 'package:motel_guide/utils/format_utils.dart'; 
import '../../models/suite_model.dart';

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
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  suite.fotos.first,
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 20,
                alignment: Alignment.center,
                child: Text(
                  formatarNomeSuite(suite.nome), 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
