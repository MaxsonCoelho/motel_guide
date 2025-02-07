import 'package:flutter/material.dart';

class SuiteItemIcons extends StatelessWidget {
  final List<String> itens;

  SuiteItemIcons({required this.itens});

  final Map<String, IconData> itemIcons = {
    "ducha dupla": Icons.shower,
    "TV a cabo": Icons.tv,
    "TV LED 32''": Icons.live_tv,
    "iluminação por leds": Icons.lightbulb,
    "garagem coletiva": Icons.directions_car,
    "som AM/FM": Icons.speaker,
    "3 canais eróticos": Icons.theaters,
    "bluetooth": Icons.bluetooth,
    "espelho no teto": Icons.crop_square,
    "acesso à suíte via escadas": Icons.stairs,
    "frigobar": Icons.kitchen,
    "ar-condicionado split": Icons.ac_unit,
    "WI-FI": Icons.wifi,
    "secador de cabelo": Icons.air,
  };

  @override
  Widget build(BuildContext context) {
    List<String> itensComIcone = itens.where((item) => itemIcons.containsKey(item)).toList();

    if (itensComIcone.isEmpty) return SizedBox.shrink(); 

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
      margin: EdgeInsets.symmetric(vertical: 0), 
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: itensComIcone.take(4).map((item) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6), 
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 18, 
                    child: Icon(
                      itemIcons[item],
                      color: Colors.black54,
                      size: 20, 
                    ),
                  ),
                );
              }).toList(),
            ),

            if (itensComIcone.length > 4)
              GestureDetector(
                onTap: () {
                },
                child: Row(
                  children: [
                    Text("Ver todos", style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(width: 5), 
                    Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
