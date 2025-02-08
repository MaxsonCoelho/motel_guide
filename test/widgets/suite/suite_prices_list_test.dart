import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:motel_guide/utils/format_utils.dart';
import 'package:motel_guide/widgets/suite/suite_prices_list.dart';
import 'package:motel_guide/models/suite_model.dart';

void main() {
  testWidgets('Deve exibir corretamente os preços dos períodos sem desconto', (WidgetTester tester) async {
    final periodos = [
      Periodo(tempoFormatado: '1h', valor: 100.0, valorTotal: 100.0, temCortesia: false),
      Periodo(tempoFormatado: '2h', valor: 180.0, valorTotal: 180.0, temCortesia: false),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SuitePricesList(periodos: periodos)),
    ));

    await tester.pumpAndSettle();

    expect(find.text('1h'), findsOneWidget);
    expect(find.text(formatarPreco(100.0)), findsOneWidget);

    expect(find.text('2h'), findsOneWidget);
    expect(find.text(formatarPreco(180.0)), findsOneWidget);

    expect(find.byIcon(Icons.keyboard_arrow_right), findsNWidgets(2));
  });

  testWidgets('Deve exibir corretamente os preços dos períodos com desconto', (WidgetTester tester) async {
    final periodos = [
      Periodo(
        tempoFormatado: '1h',
        valor: 100.0,
        valorTotal: 80.0,
        temCortesia: false,
        desconto: Desconto(desconto: 20.0),
      ),
      Periodo(
        tempoFormatado: '3h',
        valor: 250.0,
        valorTotal: 200.0,
        temCortesia: false,
        desconto: Desconto(desconto: 20.0),
      ),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SuitePricesList(periodos: periodos)),
    ));

    await tester.pumpAndSettle();

    expect(find.text('1h'), findsOneWidget);
    expect(find.text('3h'), findsOneWidget);

    //Agora espera dois elementos "20% off"
    expect(find.text('20% off'), findsNWidgets(2));

    //Preços normais (riscados)
    expect(find.text(formatarPreco(100.0)), findsOneWidget);
    expect(find.text(formatarPreco(250.0)), findsOneWidget);

    //Preços com desconto
    expect(find.text(formatarPreco(80.0)), findsOneWidget);
    expect(find.text(formatarPreco(200.0)), findsOneWidget);
  });

  testWidgets('Deve renderizar corretamente sem períodos', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SuitePricesList(periodos: [])),
    ));

    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNothing);
  });
}
