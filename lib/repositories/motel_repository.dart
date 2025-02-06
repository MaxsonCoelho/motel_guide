import '../models/motel_model.dart';
import '../services/api_service.dart';

class MotelRepository {
  final ApiService apiService;

  MotelRepository(this.apiService);

  Future<List<Motel>> getMotels() async {
    try {
      final motels = await apiService.fetchMotels();
      print("✅ Dados carregados do repositório: ${motels.length} motéis encontrados");
      return motels;
    } catch (e) {
      print("❌ Erro no repository: $e");
      rethrow; 
    }
  }
}
