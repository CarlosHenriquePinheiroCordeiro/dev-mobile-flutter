import 'package:app_final_previsao_tempo/LocalizacaoModel.dart';
import 'package:app_final_previsao_tempo/TelaPrincipal.dart';
import 'package:flutter/material.dart';
import 'FuncoesLocalizacao.dart';

void main() {
  runApp(AppTemperatura());
}

class AppTemperatura extends StatelessWidget {
  @override
  FuncoesLocalizacao oFc = FuncoesLocalizacao();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão Temperaturas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: oFc.getLocalizacoes(),
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


}