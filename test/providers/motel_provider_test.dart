import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:motel_guide/models/motel_model.dart';
import 'package:motel_guide/providers/motel_provider.dart';
import 'package:motel_guide/repositories/motel_repository.dart';
import '../mocks/motel_provider_test.mocks.dart'; 

@GenerateNiceMocks([MockSpec<MotelRepository>()])
void main() {
  late MotelNotifier motelNotifier;
  late MockMotelRepository mockRepository;

  setUp(() {
    mockRepository = MockMotelRepository();
  });

  test('Estado inicial deve ser AsyncValue.loading()', () {
    motelNotifier = MotelNotifier(mockRepository);
    
    expect(motelNotifier.state, isA<AsyncLoading>());
  });

  test('fetchMotels() deve carregar motéis com sucesso', () async {
    final fakeMotels = [
      Motel(
        nome: 'Motel Luxo',
        bairro: 'Centro',
        imagem: 'url_imagem',
        distancia: 2.0,
        mediaAvaliacoes: 4.5, 
        qtdAvaliacoes: 120,   
        imagemSuite: 'url_suite', 
        suites: [],
      ),
    ];

    when(mockRepository.getMotels()).thenAnswer((_) async => fakeMotels);

    motelNotifier = MotelNotifier(mockRepository);
    await motelNotifier.fetchMotels();

    expect(motelNotifier.state, equals(AsyncValue.data(fakeMotels)));
  });

  test('fetchMotels() deve retornar erro se a requisição falhar', () async {
    final exception = Exception('Erro ao carregar motéis');

    when(mockRepository.getMotels()).thenThrow(exception);

    motelNotifier = MotelNotifier(mockRepository);
    await motelNotifier.fetchMotels();

    expect(motelNotifier.state, isA<AsyncError>());
  });
}
