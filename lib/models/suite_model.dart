class Suite {
  final String nome;
  final List<String> fotos;
  final List<String> itens;
  final List<Periodo> periodos;

  Suite({
    required this.nome,
    required this.fotos,
    required this.itens,
    required this.periodos,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      nome: json['nome'] ?? 'Suíte Desconhecida',
      fotos: (json['fotos'] as List?)?.map((f) => f as String).toList() ?? [],
      itens: (json['itens'] as List?)
              ?.map((item) => item['nome'] as String)
              .toList() ??
          [],
      periodos: (json['periodos'] as List?)
              ?.map((p) => Periodo.fromJson(p))
              .toList() ??
          [],
    );
  }

  static List<Suite> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((json) => Suite.fromJson(json)).toList();
  }
}

// ✅ Classe que representa um período de preços
class Periodo {
  final String tempoFormatado;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final Desconto? desconto;

  Periodo({
    required this.tempoFormatado,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });

  factory Periodo.fromJson(Map<String, dynamic> json) {
    return Periodo(
      tempoFormatado: json['tempoFormatado'] ?? '',
      valor: (json['valor'] ?? 0).toDouble(),
      valorTotal: (json['valorTotal'] ?? 0).toDouble(),
      temCortesia: json['temCortesia'] ?? false,
      desconto:
          json['desconto'] != null ? Desconto.fromJson(json['desconto']) : null,
    );
  }
}

class Desconto {
  final double desconto;

  Desconto({required this.desconto});

  factory Desconto.fromJson(Map<String, dynamic> json) {
    return Desconto(desconto: (json['desconto'] ?? 0).toDouble());
  }
}
