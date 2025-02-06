import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motel_guide/services/api_service.dart';
import '../models/motel_model.dart';
import '../repositories/motel_repository.dart';

// Estado que contém a lista de motéis e status de carregamento
class MotelNotifier extends StateNotifier<AsyncValue<List<Motel>>> {
  final MotelRepository repository;

  MotelNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchMotels();
  }

  Future<void> fetchMotels() async {
    state = const AsyncValue.loading();
    try {
      final motels = await repository.getMotels();
      state = AsyncValue.data(motels);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Criando o provider para ser usado na UI
final motelProvider =
    StateNotifierProvider<MotelNotifier, AsyncValue<List<Motel>>>((ref) {
  final repository = ref.watch(motelRepositoryProvider);
  return MotelNotifier(repository);
});

// Provider do repository
final motelRepositoryProvider = Provider<MotelRepository>((ref) {
  return MotelRepository(ApiService('https://jsonkeeper.com/b/1IXK'));
});
