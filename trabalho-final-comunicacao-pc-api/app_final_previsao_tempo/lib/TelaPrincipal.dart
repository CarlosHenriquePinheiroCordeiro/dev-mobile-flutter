import 'package:app_final_previsao_tempo/FormularioLocalizacao.dart';
import 'package:app_final_previsao_tempo/FuncoesLocalizacao.dart';
import 'package:app_final_previsao_tempo/LocalizacaoModel.dart';
import 'package:app_final_previsao_tempo/TemperaturaLocalizacao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.localizacoes.map((localizacao) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _irParaPaginaDetalhes(context, localizacao.nome, localizacao.coordenadas);
                      },
                      child: Text('${localizacao.id} - ${localizacao.nome}'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _excluirLocalizacao(localizacao.id);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioLocalizacao(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _excluirLocalizacao(int id) async {
    final response = await http.delete(Uri.parse('http://127.0.0.1:8000/localizacao/$id'));
    if (response.statusCode == 200) {
      FuncoesLocalizacao fc = FuncoesLocalizacao();
      List<LocalizacaoModel> aLocalizacoes = await fc.getLocalizacoes();
      setState(() {
        widget.localizacoes.clear();
        widget.localizacoes.addAll(aLocalizacoes);
      });
    } else {
      throw Exception('Falha na requisição');
    }
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