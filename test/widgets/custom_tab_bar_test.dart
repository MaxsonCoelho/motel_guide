import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motel_guide/widgets/custom_tab_bar.dart'; 

void main() {
  testWidgets('CustomTabBar deve ser renderizado corretamente', (WidgetTester tester) async {
    int selectedTab = -1;
    expect(selectedTab, isNotNull); 

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTabBar(
          onTabSelected: (index) {
            selectedTab = index;
          },
        ),
      ),
    ));

    //Verifica se os botões principais estão visíveis.
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text("Ir Agora"), findsOneWidget);
    expect(find.text("Ir Outro Dia"), findsOneWidget);
    expect(find.text("São Paulo"), findsOneWidget);
  });

  testWidgets('Deve mudar a aba ao clicar nos botões de seleção', (WidgetTester tester) async {
    int selectedTab = -1;
    expect(selectedTab, isNotNull);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTabBar(
          onTabSelected: (index) {
            selectedTab = index;
          },
        ),
      ),
    ));

    //Clicar no botão "Ir Agora"
    await tester.tap(find.text("Ir Agora"));
    await tester.pumpAndSettle();
    expect(selectedTab, equals(1));

    //Clicar no botão "Ir Outro Dia"
    await tester.tap(find.text("Ir Outro Dia"));
    await tester.pumpAndSettle();
    expect(selectedTab, equals(2));
  });

  testWidgets('Deve chamar o callback ao clicar no menu e pesquisa', (WidgetTester tester) async {
    int selectedTab = -1;
    expect(selectedTab, isNotNull); 

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTabBar(
          onTabSelected: (index) {
            selectedTab = index;
          },
        ),
      ),
    ));

    //Clicar no botão de menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(selectedTab, equals(0));

    //Clicar no botão de pesquisa
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(selectedTab, equals(3));
  });
}
