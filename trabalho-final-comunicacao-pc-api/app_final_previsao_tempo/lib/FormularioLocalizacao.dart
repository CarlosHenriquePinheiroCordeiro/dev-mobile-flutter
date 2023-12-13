import 'dart:convert';

import 'package:app_final_previsao_tempo/FuncoesLocalizacao.dart';
import 'package:app_final_previsao_tempo/LocalizacaoModel.dart';
import 'package:app_final_previsao_tempo/TelaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormularioLocalizacao extends StatefulWidget {
  @override
  _FormularioLocalizacaoState createState() => _FormularioLocalizacaoState();
}

class _FormularioLocalizacaoState extends State<FormularioLocalizacao> {
  final _xKeyFormulario = GlobalKey<FormState>();
  final _sNomeController = TextEditingController();
  final _sCoordenadasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Localização'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _xKeyFormulario,
          child: Column(
            children: [
              TextFormField(
                controller: _sNomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (xValor) {
                  if (xValor == null || xValor.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sCoordenadasController,
                decoration: InputDecoration(labelText: 'Coordenadas'),
                validator: (xValor) {
                  if (xValor == null || xValor.isEmpty) {
                    return 'Insira as coordenadas';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _submitaFormulario();
                },
                child: Text('Adicionar Localização'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitaFormulario() async {
    if (_xKeyFormulario.currentState?.validate() ?? false) {
      final oBody = jsonEncode({
        'nome': _sNomeController.text,
        'coordenadas': _sCoordenadasController.text,
      });
      try {
        final oResposta = await http.post(
          Uri.parse('http://127.0.0.1:8000/localizacao/'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: oBody,
        );
        if (oResposta.statusCode == 200) {
          FuncoesLocalizacao fc = FuncoesLocalizacao();
          List<LocalizacaoModel> aLocalizacoes = await fc.getLocalizacoes();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaPrincipal(localizacoes: aLocalizacoes),
            ),
          );  
        } else {
          print('Falha ao adicionar localização. Código de status: ${oResposta.statusCode}');
        }
      } catch (error) {
        print('Erro ao adicionar localização: $error');
      }
    }
  }
}
