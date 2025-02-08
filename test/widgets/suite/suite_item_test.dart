import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:motel_guide/models/suite_model.dart';
import 'package:motel_guide/widgets/suite/suite_item.dart';
import 'dart:typed_data';
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

  testWidgets('Deve exibir corretamente a suíte com imagem e nome formatado', (WidgetTester tester) async {
    final suite = Suite(
      nome: 'Suíte Luxo',
      fotos: ['https://fakeurl.com/suite_luxo.jpg'],
      itens: [],
      periodos: [],
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SuiteItem(suite: suite)),
    ));

    await tester.pumpAndSettle();

    //Verifica se o nome da suíte aparece
    expect(find.text('Suíte Luxo'), findsOneWidget);

    //Verifica se a imagem foi carregada corretamente
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  testWidgets('Deve exibir corretamente o nome centralizado', (WidgetTester tester) async {
    final suite = Suite(
      nome: 'Suíte Premium',
      fotos: ['https://fakeurl.com/suite_premium.jpg'],
      itens: [],
      periodos: [],
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SuiteItem(suite: suite)),
    ));

    await tester.pumpAndSettle();

    //Verifica se o nome está centralizado
    final textFinder = find.text('Suíte Premium');
    expect(textFinder, findsOneWidget);
    expect(tester.getTopLeft(textFinder).dx, greaterThan(0));
  });
}

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }
}
