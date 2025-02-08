import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:motel_guide/widgets/suite/suite_item_icons.dart';

void main() {
  group('SuiteItemIcons Widget Tests', () {
    testWidgets('Deve exibir os ícones corretamente para os itens suportados', (WidgetTester tester) async {
      final itens = ["TV a cabo", "frigobar", "WI-FI", "ar-condicionado split"];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: SuiteItemIcons(itens: itens)),
      ));

      await tester.pumpAndSettle();

      //Garante que o Card foi renderizado
      expect(find.byType(Card), findsOneWidget);

      //Garante que os 4 ícones aparecem
      expect(find.byType(Icon), findsNWidgets(4));

      //Garante que os ícones corretos estão sendo usados
      expect(find.byIcon(Icons.tv), findsOneWidget);
      expect(find.byIcon(Icons.kitchen), findsOneWidget);
      expect(find.byIcon(Icons.wifi), findsOneWidget);
      expect(find.byIcon(Icons.ac_unit), findsOneWidget);
    });

    testWidgets('Não deve renderizar nada se não houver itens suportados', (WidgetTester tester) async {
      final itens = ["Item desconhecido", "Outro item sem ícone"];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: SuiteItemIcons(itens: itens)),
      ));

      await tester.pumpAndSettle();

      //Garante que nenhum Card foi renderizado
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('Deve exibir botão "Ver todos" quando houver mais de 4 itens', (WidgetTester tester) async {
      final itens = ["TV a cabo", "frigobar", "WI-FI", "ar-condicionado split", "secador de cabelo"];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: SuiteItemIcons(itens: itens)),
      ));

      await tester.pumpAndSettle();

      //Garante que o botão "Ver todos" aparece
      expect(find.text("Ver todos"), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });
  });
}
