import '../models/motel_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<List<Motel>> fetchMotels() async {
    final response = await http.get(Uri.parse(apiUrl));

    if(response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Motel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load motels');
    }
  }
}