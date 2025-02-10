import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motel_guide/widgets/map_floating_action_button.dart';

void main() {
  testWidgets('Deve exibir o botão de mapa corretamente', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MapaFloatingButton(
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    //Verifica se o ícone e o texto estão na tela
    expect(find.text("Mapa"), findsOneWidget);
    expect(find.byIcon(Icons.map), findsOneWidget);

    //Simula o clique no botão
    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(pressed, true);
  });
}
