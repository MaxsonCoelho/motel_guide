import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motel_guide/models/motel_model.dart';
import 'package:motel_guide/models/suite_model.dart';
import 'package:motel_guide/widgets/motel/motel_item.dart';
import 'package:motel_guide/widgets/suite/suite_list.dart';
import 'dart:io';
import 'dart:typed_data';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUpAll(() async {
    HttpOverrides.global = TestHttpOverrides(); 

    // Mock para carregamento de assets
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (message) async {
        return Future.value(ByteData.sublistView(Uint8List(1024))); // Simula 1KB de dados
      },
    );
  });

  late Motel motel;

  setUp(() {
    motel = Motel(
      nome: 'Motel Luxo',
      imagem: 'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg', 
      bairro: 'Centro',
      distancia: 2.5,
      mediaAvaliacoes: 4.5,
      qtdAvaliacoes: 120,
      imagemSuite: 'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg', 
      suites: [],
    );
  });

  testWidgets('Deve renderizar corretamente com os detalhes do motel', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: MotelItem(motel)),
    ));

    await tester.pumpAndSettle(); 

    expect(find.text('Motel Luxo'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('Centro'), findsOneWidget);
    expect(find.text('2.5 km'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('120 avaliações'), findsOneWidget);
  });

  testWidgets('Deve alternar o estado do botão de favoritos ao clicar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: MotelItem(motel)),
    ));

    await tester.pumpAndSettle(); 

    // Debug: Lista todos os ícones encontrados na tela
    final allIcons = tester.widgetList<Icon>(find.byType(Icon)).map((icon) => icon.icon).toList();
    print('Ícones encontrados na tela: $allIcons');

    // Ajustado para procurar o ícone correto
    final favoriteIconBefore = find.byIcon(Icons.favorite_rounded);
    expect(favoriteIconBefore, findsOneWidget);

    // Garante que o botão está visível antes de tocar
    await tester.ensureVisible(favoriteIconBefore);
    await tester.tap(favoriteIconBefore);
    await tester.pumpAndSettle(); 

    // Verifica se o ícone mudou para 'favorito preenchido'
    final favoriteIconAfter = find.byIcon(Icons.favorite);
    expect(favoriteIconAfter, findsOneWidget);
  });

  testWidgets('Deve exibir a lista de suítes', (WidgetTester tester) async {
    final motelComSuites = Motel(
      nome: 'Motel Luxo',
      imagem: 'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg', 
      bairro: 'Centro',
      distancia: 2.5,
      mediaAvaliacoes: 4.5,
      qtdAvaliacoes: 120,
      imagemSuite: 'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg',
      suites: [
        Suite(
          nome: 'Suíte VIP',
          fotos: ['https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg'],
          itens: [],
          periodos: [Periodo(tempoFormatado: '1h', valor: 100.0, valorTotal: 100.0, temCortesia: false)],
        ),
        Suite(
          nome: 'Suíte Premium',
          fotos: ['https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg'],
          itens: [],
          periodos: [Periodo(tempoFormatado: '2h', valor: 180.0, valorTotal: 180.0, temCortesia: false)],
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: MotelItem(motelComSuites)),
    ));

    await tester.pumpAndSettle(); 

    expect(find.byType(SuiteList), findsOneWidget);
    expect(find.text('Suíte VIP'), findsOneWidget);
    expect(find.text('Suíte Premium'), findsOneWidget);
  });
}
