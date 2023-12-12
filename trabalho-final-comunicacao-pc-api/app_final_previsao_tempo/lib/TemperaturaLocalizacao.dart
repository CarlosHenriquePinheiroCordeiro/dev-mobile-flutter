import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TemperaturaLocalizacao extends StatefulWidget {
  final String nome;
  final String coordenadas;

  TemperaturaLocalizacao({required this.nome, required this.coordenadas});

  @override
  _TemperaturaLocalizacaoState createState() => _TemperaturaLocalizacaoState();
}

class _TemperaturaLocalizacaoState extends State<TemperaturaLocalizacao> {
  late List<String> temperaturas;

  @override
  void initState() {
    super.initState();
    temperaturas = [];
    _fetchTemperaturas();
  }

  Future<void> _fetchTemperaturas() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.tomorrow.io/v4/timelines?location=${widget.coordenadas}&fields=temperature&timesteps=1h&units=metric&apikey=DgIMoLug9D6L7NaP6AoFQBjlDyvKlpir',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final intervals = data['data']['timelines'][0]['intervals'] as List<dynamic>;

        setState(() {
          temperaturas = intervals.map((interval) {
            final temperature = interval['values']['temperature'].toString();
            final timestamp = interval['startTime'];
            return 'Hora: $timestamp, Temperatura: $temperature °C';
          }).toList();
        });
      } else {
        print('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperaturas previstas para ${widget.nome}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (temperaturas != null)
              Expanded(
                child: ListView.builder(
                  itemCount: temperaturas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(temperaturas[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
