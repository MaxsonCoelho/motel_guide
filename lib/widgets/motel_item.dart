import 'package:flutter/material.dart';
import '../models/motel_model.dart';
import '../models/suite_model.dart';

class MotelItem extends StatefulWidget {
  final Motel motel;

  MotelItem(this.motel);

  @override
  _MotelItemState createState() => _MotelItemState();
}

class _MotelItemState extends State<MotelItem> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double suiteWidth = screenWidth * 0.95; 

    return Hero(
      tag: widget.motel.nome,
      child: Container(
        color: Colors.grey[200], 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.motel.imagem),
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.motel.nome,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.motel.bairro, style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text(
                        '${widget.motel.distancia.toStringAsFixed(1)} km',
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text(
                              widget.motel.mediaAvaliacoes.toStringAsFixed(1),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "${widget.motel.qtdAvaliacoes} avaliações",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20),
                        onPressed: () {}, 
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              height: 350, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.motel.suites.length,
                padding: EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  Suite suite = widget.motel.suites[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 8), // 🔹 Espaço entre as suítes
                    child: SizedBox(
                      width: suiteWidth, // 🔹 Cada suíte ocupa 95% da largura da tela
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

                              // 🔹 Itens da suíte
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Itens da Suíte", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Wrap(
                                      spacing: 8,
                                      children: suite.itens.take(4).map((item) {
                                        return Chip(
                                          label: Text(item, style: TextStyle(fontSize: 12, color: Colors.grey)),
                                          backgroundColor: Colors.grey[200],
                                        );
                                      }).toList(),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Ver todos os itens", style: TextStyle(color: Colors.grey)),
                                          Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Column(
                                children: suite.periodos.map((periodo) {
                                  return Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                periodo.tempoFormatado,
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              if (periodo.desconto != null) ...[
                                                SizedBox(width: 8),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.green),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Text(
                                                    "${periodo.desconto!.desconto}% OFF",
                                                    style: TextStyle(color: Colors.green, fontSize: 12),
                                                  ),
                                                ),
                                              ]
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              if (periodo.desconto != null) ...[
                                                Text(
                                                  "R\$ ${periodo.valor.toStringAsFixed(2)}",
                                                  style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough),
                                                ),
                                                SizedBox(width: 6),
                                              ],
                                              Text(
                                                "R\$ ${periodo.valorTotal.toStringAsFixed(2)}",
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(width: 6),
                                              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
