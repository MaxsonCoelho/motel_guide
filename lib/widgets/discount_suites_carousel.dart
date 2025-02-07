import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motel_guide/models/suite_model.dart';
import 'package:motel_guide/utils/format_utils.dart';
import '../models/motel_model.dart';

class DiscountSuitesCarousel extends StatefulWidget {
  final List<Motel> moteis;

  DiscountSuitesCarousel({required this.moteis});

  @override
  _DiscountSuitesCarouselState createState() => _DiscountSuitesCarouselState();
}

class _DiscountSuitesCarouselState extends State<DiscountSuitesCarousel> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  List<Map<String, dynamic>> _suitesComDesconto = [];

  @override
  void initState() {
    super.initState();
    _filtrarSuitesComDesconto();
    _startAutoScroll();
  }

  void _filtrarSuitesComDesconto() {
    List<Map<String, dynamic>> tempList = [];

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
          tempList.add({
            'motelNome': motel.nome,
            'bairro': motel.bairro,
            'suiteNome': suite.nome,
            'foto': suite.fotos.isNotEmpty ? suite.fotos.first : motel.imagemSuite,
            'desconto': periodoComDesconto.desconto!.desconto,
            'valorAPartirDe': periodoComDesconto.valorTotal,
          });
        }
      }
    }

    setState(() {
      _suitesComDesconto = tempList;
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentIndex < _suitesComDesconto.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_suitesComDesconto.isEmpty) return SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _suitesComDesconto.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final suite = _suitesComDesconto[index];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            suite['foto'],
                            width: MediaQuery.of(context).size.width * 0.5, 
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      suite['motelNome'],
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      suite['bairro'],
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 8),

                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Center(
                                  child: Text(
                                    "${formatarDesconto(suite['desconto'].toString())}% de desconto",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 8),

                              Container(
                                padding: EdgeInsets.all(8),
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "A partir de ${formatarPreco(suite['valorAPartirDe'])}",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 5),

                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(255, 21, 158, 26),
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Reservar", style: TextStyle(fontSize: 14, color: Colors.white)),
                                            SizedBox(width: 5),
                                            Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_suitesComDesconto.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.red : Colors.grey[400],
              ),
            );
          }),
        ),
      ],
    );
  }
}
