import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motel_guide/widgets/filter_bar.dart';

void main() {
  testWidgets('StickyFilterBar deve ser renderizado corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: StickyFilterBar(), 
                pinned: true,
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(CustomScrollView), findsOneWidget); 
  });

  testWidgets('Deve rolar a barra ao clicar nos botões de seta', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: StickyFilterBar(),
                pinned: true,
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Simula o scroll da lista para a direita
    await tester.drag(find.byType(ListView), const Offset(-100, 0));
    await tester.pumpAndSettle();

    // Verifica se os botões de seta aparecem corretamente
    expect(find.byIcon(Icons.keyboard_arrow_right), findsOneWidget);
  });
}
