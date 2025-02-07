import 'package:intl/intl.dart';

//Remove tudo que vem depois do ponto no valor do desconto
String formatarDesconto(String desconto) {
  return desconto.split('.').first; // Pega apenas a parte antes do ponto
}

//Formata um valor monetário para o formato brasileiro (R$ XX,XX)
String formatarPreco(double valor) {
  final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  return formatter.format(valor);
}

//Remove qualquer trecho que comece com "s/" e o espaço antes dele
String formatarNomeSuite(String nome) {
  return nome.split(" s/").first.trim(); 
}
