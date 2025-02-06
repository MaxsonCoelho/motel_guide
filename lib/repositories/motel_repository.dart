import '../services/api_service.dart';
import '../models/motel_model.dart';

class MotelRepository {
  final ApiService apiService;

  MotelRepository(this.apiService);

  Future<List<Motel>> getMotels() async {
    return await apiService.fetchMotels();
  }
}