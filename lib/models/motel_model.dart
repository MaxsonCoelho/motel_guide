import 'suite_model.dart';

class Motel {
  final String nome;
  final String imagem;
  final String bairro;
  final double distancia;
  final double mediaAvaliacoes;
  final int qtdAvaliacoes;
  final List<Suite> suites;
  final String imagemSuite; 

  Motel({
    required this.nome,
    required this.imagem,
    required this.bairro,
    required this.distancia,
    required this.mediaAvaliacoes,
    required this.qtdAvaliacoes,
    required this.suites,
    required this.imagemSuite, 
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    List<Suite> suites = Suite.fromJsonList(json['suites'] as List?);

    return Motel(
      nome: json['fantasia'] ?? 'Nome Desconhecido',
      imagem: json['logo'] ?? '',
      bairro: json['bairro'] ?? 'Localização não informada',
      distancia: (json['distancia'] ?? 0).toDouble(),
      mediaAvaliacoes: (json['media'] ?? 0.0).toDouble(),
      qtdAvaliacoes: json['qtdAvaliacoes'] ?? 0,
      suites: suites,
      imagemSuite: (suites.isNotEmpty && suites.first.fotos.isNotEmpty)
          ? suites.first.fotos.first // 📸 Pegando a primeira imagem da primeira suíte
          : 'https://via.placeholder.com/150', // 🔹 Imagem padrão caso não tenha
    );
  }

  static List<Motel> fromJsonList(Map<String, dynamic> json) {
    if (json['sucesso'] == true && json['data'] != null && json['data']['moteis'] != null) {
      return (json['data']['moteis'] as List)
          .map((motel) => Motel.fromJson(motel))
          .toList();
    }
    return [];
  }
}
