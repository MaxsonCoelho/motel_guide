import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:motel_guide/models/suite_model.dart';
import 'package:motel_guide/utils/format_utils.dart';
import 'package:motel_guide/widgets/reserve_button.dart';
import '../../models/motel_model.dart';

class DiscountSuitesList extends StatefulWidget {
  final List<Motel> moteis;

  DiscountSuitesList({required this.moteis});

  @override
  _DiscountSuitesListState createState() => _DiscountSuitesListState();
}

class _DiscountSuitesListState extends State<DiscountSuitesList> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> suitesComDesconto = _filtrarSuitesComDesconto();
    if (suitesComDesconto.isEmpty) return SizedBox.shrink();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "🔥 Descontos Incríveis",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: screenHeight * 0.5,
            child: PageView.builder(
              controller: _pageController,
              itemCount: suitesComDesconto.length,
              physics: PageScrollPhysics(),
              itemBuilder: (context, index) {
                final suite = suitesComDesconto[index];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            suite['foto'],
                            height: screenHeight * 0.45,
                            width: screenWidth * 0.9,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned(
                          bottom: Platform.isIOS ? 60 : 50, 
                          left: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${formatarDesconto(suite['desconto'].toString())}% de desconto",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        suite['motelNome'],
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        suite['bairro'],
                                        style: TextStyle(color: Colors.black54),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 10),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ReserveButton(
                                        onPressed: () {
                                          print("Reservando suíte ${suite['motelNome']}");
                                        },
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "A partir de ${formatarPreco(suite['valorAPartirDe'])}",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filtrarSuitesComDesconto() {
    List<Map<String, dynamic>> suitesComDesconto = [];

    for (var motel in widget.moteis) {
      for (var suite in motel.suites) {
        var periodoComDesconto = suite.periodos.firstWhere(
          (p) => p.desconto != null,
          orElse: () => Periodo(
            tempoFormatado: '',
            valor: 0,
            valorTotal: 0,
            temCortesia: false,
            desconto: null,
          ),
        );

        if (periodoComDesconto.desconto != null) {
          suitesComDesconto.add({
            'motelNome': motel.nome,
            'bairro': motel.bairro,
            'foto': suite.fotos.isNotEmpty ? suite.fotos.first : motel.imagemSuite,
            'desconto': periodoComDesconto.desconto!.desconto,
            'valorAPartirDe': periodoComDesconto.valorTotal,
          });
        }
      }
    }

    return suitesComDesconto;
  }
}
