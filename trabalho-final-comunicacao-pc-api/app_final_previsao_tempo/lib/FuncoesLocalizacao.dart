import 'dart:convert';
import 'package:app_final_previsao_tempo/LocalizacaoModel.dart';
import 'package:http/http.dart' as http;

class FuncoesLocalizacao {

  Future<List<LocalizacaoModel>> getLocalizacoes() async {
    final oResposta = await http.get(Uri.parse('http://127.0.0.1:8000/localizacao'));

    if (oResposta.statusCode == 200) {
      final List<dynamic> aJson = json.decode(oResposta.body);
      List<LocalizacaoModel> aLocalizacoes = aJson.map((aDados) => LocalizacaoModel.fromJson(aDados)).toList();
      return aLocalizacoes;
    } else {
      throw Exception('Falha na requisição');
    }
  }

  
}