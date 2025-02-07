import 'package:flutter/material.dart';
import 'package:motel_guide/utils/format_utils.dart'; 
import '../../models/suite_model.dart';

class SuitePricesList extends StatelessWidget {
  final List<Periodo> periodos;

  SuitePricesList({required this.periodos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periodos.map((periodo) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            periodo.tempoFormatado,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          if (periodo.desconto != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${formatarDesconto(periodo.desconto!.desconto.toString())}% off', 
                                  style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          if (periodo.desconto != null)
                            Text(
                              formatarPreco(periodo.valor),
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          SizedBox(width: 6),
                          Text(
                            formatarPreco(periodo.valorTotal), 
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.keyboard_arrow_right, size: 22, color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
