import 'dart:convert';

import 'package:app_final_previsao_tempo/LocalizacaoModel.dart';
import 'package:app_final_previsao_tempo/TelaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(AppTemperatura());
}

class AppTemperatura extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sua Aplicação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return TelaPrincipal(localizacoes: snapshot.data as List<LocalizacaoModel>);
            } else {
              return Container(
                color: Colors.red,
                child: Center(
                  child: Text('Erro ao obter dados'),
                ),
              );
            }
          } else {
            // Enquanto a requisição está em andamento, exiba um indicador de carregamento
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<List<LocalizacaoModel>> fetchData() async {
    // Sua lógica para fazer a requisição HTTP e obter dados
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/localizacao'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<LocalizacaoModel> localizacoes = jsonData.map((data) => LocalizacaoModel.fromJson(data)).toList();
      return localizacoes;
    } else {
      throw Exception('Falha na requisição');
    }
  }
}