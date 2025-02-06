import 'package:flutter/material.dart';

class SuiteItemIcons extends StatelessWidget {
  final List<String> itens;

  SuiteItemIcons({required this.itens});

  final Map<String, IconData> itemIcons = {
    "ducha dupla": Icons.shower,
    "TV a cabo": Icons.tv,
    "TV LED 32''": Icons.tv,
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

    if (itensComIcone.isEmpty) return SizedBox.shrink(); // 🔹 Oculta se não houver ícones

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // 🔹 Mesma borda dos outros cards
      elevation: 4, // 🔹 Adiciona sombra para destacar
      margin: EdgeInsets.symmetric(vertical: 6), // 🔹 Espaçamento superior e inferior
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10), // 🔹 Padding interno
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 🔹 Ícones (máximo 4)
            Row(
              children: itensComIcone.take(4).map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 20,
                    child: Icon(
                      itemIcons[item],
                      color: Colors.black54,
                    ),
                  ),
                );
              }).toList(),
            ),

            // 🔹 "Ver todos" (se houver mais de 4 itens)
            if (itensComIcone.length > 4)
              GestureDetector(
                onTap: () {
                  // 🚀 Futuro: Exibir todos os itens em outra tela
                },
                child: Row(
                  children: [
                    Text("Ver todos", style: TextStyle(color: Colors.grey)),
                    Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
