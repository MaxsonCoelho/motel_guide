import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motel_guide/services/api_service.dart';
import '../models/motel_model.dart';
import '../repositories/motel_repository.dart';

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

final motelProvider =
    StateNotifierProvider<MotelNotifier, AsyncValue<List<Motel>>>((ref) {
  final repository = ref.watch(motelRepositoryProvider);
  return MotelNotifier(repository);
});


final motelRepositoryProvider = Provider<MotelRepository>((ref) {
  return MotelRepository(ApiService('https://jsonkeeper.com/b/1IXK'));
});
