import 'package:flutter_test/flutter_test.dart';
import 'package:motel_guide/utils/format_utils.dart';

/// Função auxiliar para normalizar os textos e remover espaços invisíveis.
String normalizarTexto(String texto) {
  return texto.replaceAll('\u00A0', ' ').trim();
}

void main() {
  group('formatarDesconto', () {
    test('Deve remover tudo após o ponto', () {
      expect(formatarDesconto('30.5'), '30');
      expect(formatarDesconto('10.99'), '10');
      expect(formatarDesconto('100.0'), '100');
    });

    test('Deve retornar o valor original se não houver ponto', () {
      expect(formatarDesconto('50'), '50');
      expect(formatarDesconto('123'), '123');
    });
  });

  group('formatarPreco', () {
    test('Deve formatar o valor no padrão brasileiro', () {
      expect(normalizarTexto(formatarPreco(30.5)), 'R\$ 30,50');
      expect(normalizarTexto(formatarPreco(10.99)), 'R\$ 10,99');
      expect(normalizarTexto(formatarPreco(1000.75)), 'R\$ 1.000,75');
    });
  });

  group('formatarNomeSuite', () {
    test('Deve remover "s/" e o que vem depois', () {
      expect(formatarNomeSuite('Suíte Master s/ Hidro'), 'Suíte Master');
      expect(formatarNomeSuite('Quarto Luxo s/ Ar-condicionado'), 'Quarto Luxo');
    });

    test('Deve retornar o nome original se não houver "s/"', () {
      expect(formatarNomeSuite('Suíte Presidencial'), 'Suíte Presidencial');
      expect(formatarNomeSuite('Quarto Simples'), 'Quarto Simples');
    });
  });
}
