import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motel_guide/models/motel_model.dart';
import 'package:motel_guide/models/suite_model.dart';
import 'package:motel_guide/widgets/suite/discount_suites_carousel.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (message) async => Future.value(ByteData.sublistView(Uint8List(1024))),
    );
  });

  group('DiscountSuitesCarousel Widget Tests', () {
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

    testWidgets('Deve exibir corretamente o carrossel se houver suítes com desconto', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: DiscountSuitesCarousel(moteis: mockMoteis)),
      ));

      await tester.pumpAndSettle();

      //Verifica se o PageView foi renderizado
      expect(find.byType(PageView), findsOneWidget);

      //Garante que a primeira suíte ("Motel Luxo") está visível
      expect(find.text("Motel Luxo"), findsOneWidget);

      //Aguarda o tempo do timer (4s) para a troca automática
      await tester.pump(Duration(seconds: 4));
      await tester.pumpAndSettle();

      //Agora a segunda suíte ("Motel Premium") deve estar visível
      expect(find.text("Motel Premium"), findsOneWidget);
    });

    testWidgets('Deve permitir navegação manual entre suítes no carrossel', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: DiscountSuitesCarousel(moteis: mockMoteis)),
      ));

      await tester.pumpAndSettle();

      final pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);

      //Garante que a primeira suíte está visível antes do swipe
      expect(find.text("Motel Luxo"), findsOneWidget);
      expect(find.text("Motel Premium"), findsNothing);

      //Simula swipe manual para mudar de suíte
      await tester.drag(pageViewFinder, const Offset(-400, 0));
      await tester.pumpAndSettle();

      //Agora a segunda suíte deve estar visível
      expect(find.text("Motel Luxo"), findsNothing);
      expect(find.text("Motel Premium"), findsOneWidget);
    });

    testWidgets('Deve trocar de página automaticamente após um tempo', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: DiscountSuitesCarousel(moteis: mockMoteis)),
      ));

      await tester.pumpAndSettle();

      //Garante que a primeira suíte está visível antes da troca automática
      expect(find.text("Motel Luxo"), findsOneWidget);
      expect(find.text("Motel Premium"), findsNothing);

      //Aguarda tempo do timer (4s)
      await tester.pump(Duration(seconds: 4));
      await tester.pumpAndSettle();

      //Agora a segunda suíte deve estar visível automaticamente
      expect(find.text("Motel Luxo"), findsNothing);
      expect(find.text("Motel Premium"), findsOneWidget);
    });

    testWidgets('Deve renderizar corretamente sem suítes com desconto', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: DiscountSuitesCarousel(moteis: [])),
      ));

      await tester.pumpAndSettle();

      //Garante que nada foi renderizado
      expect(find.byType(PageView), findsNothing);
    });

    testWidgets('Deve atualizar os indicadores corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: DiscountSuitesCarousel(moteis: mockMoteis)),
      ));

      await tester.pumpAndSettle();

      //Confirma que há dois indicadores (um para cada suíte)
      expect(
        find.byWidgetPredicate((widget) =>
          widget is Container &&
          (widget.decoration as BoxDecoration?)?.shape == BoxShape.circle
        ),
        findsNWidgets(2),
      );

      final pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);

      //Simula swipe para mudar de suíte
      await tester.drag(pageViewFinder, const Offset(-400, 0));
      await tester.pumpAndSettle();

      //Agora o indicador da segunda suíte deve estar ativo
      final activeIndicator = tester.widget<Container>(
        find.byWidgetPredicate((widget) =>
          widget is Container &&
          (widget.decoration as BoxDecoration?)?.color == Colors.red
        ).last,
      );
      expect((activeIndicator.decoration as BoxDecoration).color, Colors.red);
    });
  });
}

//Mocka requisições HTTP para evitar erro 400 nas imagens
class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }
}
