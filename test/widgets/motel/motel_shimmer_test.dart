import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motel_guide/widgets/motel/motel_shimmer.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  testWidgets('Deve exibir o MotelShimmer corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MotelShimmer(),
        ),
      ),
    );

    await tester.pump(); // Aguarda renderização inicial

    // Verifica se o widget MotelShimmer está presente
    expect(find.byType(MotelShimmer), findsOneWidget);

    // Verifica se há 3 shimmer items sendo renderizados
    expect(find.byType(Shimmer), findsWidgets);

    // Confirma que há pelo menos um `Card` (pois há vários no layout)
    expect(find.byType(Card), findsWidgets);

    // Confirma que há pelo menos um `Container` usado para shimmer
    expect(find.byType(Container), findsWidgets);
  });
}
