import 'package:app_final_previsao_tempo/LocalizacaoModel.dart';
import 'package:app_final_previsao_tempo/TemperaturaLocalizacao.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  final List<LocalizacaoModel> localizacoes;

  TelaPrincipal({required this.localizacoes});

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localizações'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.localizacoes.map((localizacao) {
            return ElevatedButton(
              onPressed: () {
                _irParaPaginaDetalhes(context, localizacao.nome, localizacao.coordenadas);
              },
              child: Text('${localizacao.id} - ${localizacao.nome}'),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _irParaPaginaDetalhes(BuildContext context, String nome, String coordenadas) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemperaturaLocalizacao(nome: nome, coordenadas: coordenadas),
      ),
    );
  }
}
