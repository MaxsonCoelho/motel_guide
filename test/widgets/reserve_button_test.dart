import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motel_guide/widgets/reserve_button.dart';

void main() {
  testWidgets('ReserveButton aparece na tela', (WidgetTester tester) async {
    //Renderiza o botão na tela
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReserveButton(onPressed: () {}),
        ),
      ),
    );

    //Verifica se o texto "Reservar >" aparece
    expect(find.text('Reservar >'), findsOneWidget);
  });

  testWidgets('ReserveButton chama onPressed ao ser pressionado', (WidgetTester tester) async {
    bool foiPressionado = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReserveButton(
            onPressed: () {
              foiPressionado = true;
            },
          ),
        ),
      ),
    );

    //Simula um clique no botão
    await tester.tap(find.byType(ReserveButton));
    await tester.pump(); // Atualiza a UI

    // Verifica se a função foi chamada
    expect(foiPressionado, isTrue);
  });

  testWidgets('ReserveButton usa as cores padrão corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReserveButton(onPressed: () {}),
        ),
      ),
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

    // Verifica se as cores padrão estão corretas
    expect((button.style?.backgroundColor?.resolve({}))?.value, equals(Color.fromARGB(255, 31, 156, 54).value));
    expect((button.style?.foregroundColor?.resolve({}))?.value, equals(Colors.white.value));
  });
}
