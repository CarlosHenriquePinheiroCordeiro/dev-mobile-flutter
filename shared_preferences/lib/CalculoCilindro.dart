import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_splashscreen_assets/StateCalculo.dart';

class CalculoCilindro extends StatefulWidget {
  @override
  _CalculoCilindro createState() => _CalculoCilindro();
}

class _CalculoCilindro extends StateCalculo {

  var _iRaio        = 0.0;
  var _sKeyRaio     = 'raioCilindro';
  var _iAltura      = 0.0;
  var _sKeyAltura   = 'alturaCilindro';
  var _iAreaBase    = 0.0;
  var _iAreaLateral = 0.0;
  var _iAreaTotal   = 0.0;
  var _iVolume      = 0.0;

  @override
  Future<void> carregarValores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _iRaio   = (prefs.getDouble(_sKeyRaio) ?? 0);
    _iAltura = (prefs.getDouble(_sKeyAltura) ?? 0);
  }

  @override
  void realizaCalculos() {
    setState(() {
      _iAreaBase    = pi*(_iRaio*_iRaio);
      _iAreaLateral = 2*pi*_iRaio*_iAltura;
      _iAreaTotal   = (2*_iAreaBase)+_iAreaLateral;
      _iVolume      = _iAreaBase*_iAltura;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Cilindro')),
        body: FutureBuilder<void>(
          future: carregarValores(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  const Divider(),
                  Image.asset("assets/img/cilindro.png"),
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
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Altura (m)'),
                    initialValue: _iAltura.toStringAsFixed(2),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        value.replaceAll(',', '.');
                        _iAltura = double.parse(value);
                      }
                    }
                  ),
                  ElevatedButton(
                    onPressed: () {
                        setValorSP(_sKeyRaio, _iRaio);
                        setValorSP(_sKeyAltura, _iAltura);
                        realizaCalculos();
                    },
                    child: const Text('Calcular')
                  ),
                  const Divider(),
                  Text('Área da Base: ${_iAreaBase.toStringAsFixed(2)}m'),
                  const Divider(),
                  Text('Área Lateral: ${_iAreaLateral.toStringAsFixed(2)}m'),
                  const Divider(),
                  Text('Área Total: ${_iAreaTotal.toStringAsFixed(2)}m'),
                  const Divider(),
                  Text('Volume: ${_iVolume.toStringAsFixed(2)} metros cúbicos'),
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