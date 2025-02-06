import 'dart:convert';
import 'dart:io'; 
import '../models/motel_model.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Motel>> fetchMotels() async {
    HttpClient client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    HttpClientRequest request = await client.getUrl(Uri.parse(baseUrl));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 200) {
      final jsonString = await response.transform(utf8.decoder).join();
      final data = json.decode(jsonString);
      return Motel.fromJsonList(data);
    } else {
      throw Exception('Erro ao carregar os dados. Código: ${response.statusCode}');
    }
  }
}
