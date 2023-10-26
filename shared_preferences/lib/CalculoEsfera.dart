import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_splashscreen_assets/StateCalculo.dart';

class CalculoEsfera extends StatefulWidget {
  _CalculoEsfera createState() => _CalculoEsfera();
}

class _CalculoEsfera extends StateCalculo {

  var _iRaio        = 0.0;
  var _sKeyRaio     = 'raioEsfera';
  var _iAreaTotal   = 0.0;
  var _iVolume      = 0.0;

  @override
  Future<void> carregarValores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _iRaio = (prefs.getDouble(_sKeyRaio) ?? 0);
  }

  @override
  void realizaCalculos() {
    setState(() {
      _iAreaTotal = 4*pi*_iRaio*_iRaio;
      _iVolume    = (_iAreaTotal*_iRaio)/3;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Esfera')),
        body: FutureBuilder<void>(
          future: carregarValores(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  const Divider(),
                  Image.asset("assets/img/esfera.png"),
                  const Divider(),
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Raio (m)'),
                    initialValue: _iRaio.toStringAsFixed(2),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        value.replaceAll(',', '.');
                        _iRaio = double.parse(value);
                      }
                    }
                  ),
                  ElevatedButton(
                    onPressed: () {
                        setValorSP(_sKeyRaio, _iRaio);
                        realizaCalculos();
                    },
                    child: const Text('Calcular')
                  ),
                  const Divider(),
                  Text('Área da Superfície (Total): ${_iAreaTotal}m'),
                  const Divider(),
                  Text('Volume: ${_iVolume} metros cúbicos'),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        )
      )
    );
  }
}