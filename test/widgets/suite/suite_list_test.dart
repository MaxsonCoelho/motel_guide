import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:motel_guide/models/suite_model.dart';
import 'package:motel_guide/widgets/suite/suite_list.dart';
import 'package:motel_guide/widgets/suite/suite_item.dart';
import 'package:motel_guide/widgets/suite/suite_item_icons.dart';
import 'package:motel_guide/widgets/suite/suite_prices_list.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); 

  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (message) async => Future.value(ByteData.sublistView(Uint8List(1024))),
    );
  });

  group('SuiteList Widget Tests', () {
    final mockSuites = [
      Suite(
        nome: 'Suíte Luxo',
        fotos: ['https://fakeurl.com/suite_luxo.jpg'],
        itens: ['Ar-condicionado', 'TV a cabo'],
        periodos: [
          Periodo(tempoFormatado: '1h', valor: 100.0, valorTotal: 80.0, temCortesia: false, desconto: Desconto(desconto: 20.0)),
        ],
      ),
      Suite(
        nome: 'Suíte Premium',
        fotos: ['https://fakeurl.com/suite_premium.jpg'],
        itens: ['Wi-Fi', 'Hidromassagem'],
        periodos: [
          Periodo(tempoFormatado: '2h', valor: 200.0, valorTotal: 160.0, temCortesia: false, desconto: Desconto(desconto: 20.0)),
        ],
      ),
    ];

    testWidgets('Deve exibir corretamente a lista de suítes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: SuiteList(suites: mockSuites)),
      ));

      await tester.pumpAndSettle();

      //Verifica se os componentes principais aparecem
      expect(find.byType(SuiteItem), findsNWidgets(mockSuites.length));
      expect(find.byType(SuiteItemIcons), findsNWidgets(mockSuites.length));
      expect(find.byType(SuitePricesList), findsNWidgets(mockSuites.length));

      //Verifica se os nomes das suítes aparecem corretamente
      expect(find.text('Suíte Luxo'), findsOneWidget);
    });

    testWidgets('Deve exibir múltiplas suítes no PageView', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: SuiteList(suites: mockSuites)),
      ));

      await tester.pumpAndSettle();

      final pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);

      //Garante que a primeira suíte está visível antes do swipe
      expect(find.text('Suíte Luxo'), findsOneWidget);
      
      //Simula o swipe para a próxima suíte
      await tester.drag(pageViewFinder, Offset(-800, 0)); 
      await tester.pumpAndSettle();

      //Garante que a segunda suíte agora está visível
      expect(find.text('Suíte Premium'), findsOneWidget);
    });

    testWidgets('Deve renderizar corretamente sem suítes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: SuiteList(suites: [])),
      ));

      await tester.pumpAndSettle();

      //Garante que nenhum SuiteItem foi renderizado
      expect(find.byType(SuiteItem), findsNothing);
      expect(find.byType(SuiteItemIcons), findsNothing);
      expect(find.byType(SuitePricesList), findsNothing);
    });
  });
}

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }
}
