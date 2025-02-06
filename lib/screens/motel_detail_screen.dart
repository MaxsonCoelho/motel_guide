import 'package:flutter/material.dart';
import '../models/motel_model.dart';

class MotelDetailScreen extends StatelessWidget {
  final Motel motel;

  MotelDetailScreen(this.motel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(motel.nome)),
      body: Column(
        children: [
          Hero(
            tag: motel.nome,
            child: Image.network(motel.imagem, width: double.infinity, height: 200, fit: BoxFit.cover),
          ),
          SizedBox(height: 20),
          Text(motel.nome, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(motel.bairro, style: TextStyle(fontSize: 18, color: Colors.grey)),
          SizedBox(height: 10),
          Text('${motel.distancia.toStringAsFixed(1)} km de distância', 
              style: TextStyle(fontSize: 16, color: Colors.black54)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: Text("Reservar Agora"),
          ),
        ],
      ),
    );
  }
}
