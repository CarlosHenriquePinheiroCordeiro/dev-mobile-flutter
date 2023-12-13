import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class TemperaturaLocalizacao extends StatefulWidget {
  final String nome;
  final String coordenadas;

  TemperaturaLocalizacao({required this.nome, required this.coordenadas});

  @override
  _TemperaturaLocalizacaoState createState() => _TemperaturaLocalizacaoState();
}

class _TemperaturaLocalizacaoState extends State<TemperaturaLocalizacao> {
  late List<Widget> aTemperaturas;

  @override
  void initState() {
    super.initState();
    aTemperaturas = [];
    _fetchTemperaturas();
  }

  Future<void> _fetchTemperaturas() async {
    try {
      final oResposta = await http.get(
        Uri.parse(
          'https://api.tomorrow.io/v4/timelines?location=${widget.coordenadas}&fields=temperature&timesteps=1h&units=metric&apikey=DgIMoLug9D6L7NaP6AoFQBjlDyvKlpir',
        ),
      );
      if (oResposta.statusCode == 200) {
        final aDados      = json.decode(oResposta.body);
        final aIntervalos = aDados['data']['timelines'][0]['intervals'] as List<dynamic>;
        final oAgora      = DateTime.now();
        final oAmanha     = DateTime.now().add(Duration(days: 1));

        setState(() {
          var aHoje   = <Widget>[];
          var aAmanha = <Widget>[];

          for (var aIntervalo in aIntervalos) {
            final sTimestamp = DateTime.parse(aIntervalo['startTime']).toLocal();
            final sTemperatura = double.parse(aIntervalo['values']['temperature'].toString());
            IconData icon = Icons.wb_sunny;
            if (sTemperatura <= 10) {
              icon = Icons.ac_unit;
            }
            if (sTemperatura <= 20) {
              icon = Icons.wb_cloudy;
            }

            final sDataFormatada = DateFormat('dd/MM/yyyy, HH\'h\'').format(sTimestamp);
            final oTile = ListTile(
              leading: Icon(icon),
              title: Text('$sDataFormatada - $sTemperatura °C'),
            );

            if (sTimestamp.isBefore(oAgora)) {
              aHoje.add(oTile);
            } else if (sTimestamp.isBefore(oAmanha)) {
              aAmanha.add(oTile);
            }
          }

          if (aHoje.isNotEmpty && aAmanha.isNotEmpty) {
            aTemperaturas = [
              Text('Hoje', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ...aHoje,
              Divider(),
              Text('Amanhã', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ...aAmanha,
            ];
          } else {
            aTemperaturas = [...aHoje, ...aAmanha];
          }
        });
      } else {
        print('Erro na requisição: ${oResposta.statusCode}');
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
        child: ListView(
          children: aTemperaturas,
        ),
      ),
    );
  }
}