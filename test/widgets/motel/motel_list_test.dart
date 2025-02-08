import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motel_guide/models/motel_model.dart';
import 'package:motel_guide/providers/motel_provider.dart';
import 'package:motel_guide/widgets/motel/motel_item.dart';
import 'package:motel_guide/widgets/motel/motel_list.dart';
import 'package:motel_guide/widgets/motel/motel_shimmer.dart';
import 'package:motel_guide/repositories/motel_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/motel_repository_test.mocks.dart';
import 'dart:io';

// ✅ Gerar mock do repository
@GenerateMocks([MotelRepository])
void main() {
  late MockMotelRepository mockRepository;
  late ProviderContainer container;

  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  setUp(() {
    mockRepository = MockMotelRepository();
    container = ProviderContainer(overrides: [
      motelProvider.overrideWithProvider(
        StateNotifierProvider((ref) => MotelNotifier(mockRepository)),
      ),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  testWidgets('Deve exibir o shimmer (loading) enquanto carrega os motéis', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          motelProvider.overrideWithProvider(
            StateNotifierProvider((ref) => MotelNotifier(mockRepository)..state = const AsyncValue.loading()),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(body: MotelList()),
        ),
      ),
    );

    await tester.pump(); // Aguarda renderização

    // Confirma que o shimmer aparece
    expect(find.byType(MotelShimmer), findsOneWidget);
  });

  testWidgets('Deve exibir a mensagem de erro quando falhar', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          motelProvider.overrideWithProvider(
            StateNotifierProvider((ref) => MotelNotifier(mockRepository)
              ..state = AsyncValue.error("Erro ao buscar os motéis", StackTrace.current)),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(body: MotelList()),
        ),
      ),
    );

    await tester.pump(); 

    expect(find.text('Erro ao carregar os dados'), findsOneWidget);
    expect(find.text('Erro ao buscar os motéis'), findsOneWidget);
  });

  testWidgets('Deve exibir a lista de motéis quando houver dados', (WidgetTester tester) async {
    final mockMotels = [
      Motel(
        nome: 'Motel Luxo',
        imagem: 'https://fakeurl.com/motel_luxo.jpg',
        bairro: 'Centro',
        distancia: 2.5,
        mediaAvaliacoes: 4.5,
        qtdAvaliacoes: 120,
        imagemSuite: '',
        suites: [],
      ),
      Motel(
        nome: 'Motel Simples',
        imagem: 'https://fakeurl.com/motel_simples.jpg',
        bairro: 'Bairro X',
        distancia: 5.0,
        mediaAvaliacoes: 3.5,
        qtdAvaliacoes: 45,
        imagemSuite: '',
        suites: [],
      ),
    ];

    when(mockRepository.getMotels()).thenAnswer((_) async => mockMotels);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          motelProvider.overrideWithProvider(
            StateNotifierProvider((ref) => MotelNotifier(mockRepository)),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(body: MotelList()),
        ),
      ),
    );

    await tester.pumpAndSettle(); 

    // Confirma que os motéis aparecem
    expect(find.text("Motel Luxo"), findsOneWidget);
    expect(find.text("Motel Simples"), findsOneWidget);
    expect(find.byType(MotelItem), findsNWidgets(2));
  });
}

// Mocka requisições HTTP
class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }
}
