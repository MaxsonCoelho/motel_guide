import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motel_guide/models/motel_model.dart';
import 'package:motel_guide/models/suite_model.dart';
import 'package:motel_guide/widgets/suite/discount_suites_list.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (message) async => Future.value(ByteData.sublistView(Uint8List(1024))),
    );
  });

  group('DiscountSuitesList Widget Tests', () {
    final mockMoteis = [
      Motel(
        nome: 'Motel Luxo',
        bairro: 'Centro',
        imagem: 'https://fakeurl.com/motel_luxo.jpg',
        distancia: 2.5,
        mediaAvaliacoes: 4.5,
        qtdAvaliacoes: 120,
        imagemSuite: 'https://fakeurl.com/suite_luxo.jpg',
        suites: [
          Suite(
            nome: 'Suíte Luxo',
            fotos: ['https://fakeurl.com/suite_luxo.jpg'],
            itens: [],
            periodos: [
              Periodo(
                tempoFormatado: '1h',
                valor: 200.0,
                valorTotal: 150.0,
                temCortesia: false,
                desconto: Desconto(desconto: 25.0),
              ),
            ],
          ),
        ],
      ),
      Motel(
        nome: 'Motel Premium',
        bairro: 'Bairro X',
        imagem: 'https://fakeurl.com/motel_premium.jpg',
        distancia: 3.0,
        mediaAvaliacoes: 4.7,
        qtdAvaliacoes: 80,
        imagemSuite: 'https://fakeurl.com/suite_premium.jpg',
        suites: [
          Suite(
            nome: 'Suíte Premium',
            fotos: ['https://fakeurl.com/suite_premium.jpg'],
            itens: [],
            periodos: [
              Periodo(
                tempoFormatado: '2h',
                valor: 300.0,
                valorTotal: 240.0,
                temCortesia: false,
                desconto: Desconto(desconto: 20.0),
              ),
            ],
          ),
        ],
      ),
    ];

    testWidgets('Deve permitir navegar entre suítes no PageView', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: DiscountSuitesList(moteis: mockMoteis)),
      ));

      await tester.pumpAndSettle(); 

      final pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);

      //Garante que a primeira suíte está visível
      expect(find.text("Motel Luxo"), findsOneWidget);
      expect(find.text("Motel Premium", skipOffstage: false), findsOneWidget); 

      //Simula o swipe para a próxima suíte
      await tester.drag(pageViewFinder, const Offset(-400, 0)); 
      await tester.pumpAndSettle();

      //Agora "Motel Premium" deve estar completamente visível
      expect(find.text("Motel Luxo", skipOffstage: false), findsOneWidget); 
      expect(find.text("Motel Premium"), findsOneWidget); 
    });
  });
}

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }
}
