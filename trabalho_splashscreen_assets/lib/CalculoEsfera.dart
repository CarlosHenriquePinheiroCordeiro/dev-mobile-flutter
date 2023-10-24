import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculoEsfera extends StatefulWidget {
  _CalculoEsfera createState() => _CalculoEsfera();
}

class _CalculoEsfera extends State {
  var _iRaio        = 0.0;
  var _iAreaTotal   = 0.0;
  var _iVolume      = 0.0;
  Widget build(BuildContext context) {

    void realizaCalculos() {
      _iAreaTotal   = 4*pi*_iRaio*_iRaio;
      _iVolume      = (_iAreaTotal*_iRaio)/3;
    }

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Esfera')),
        body: Column(
          children: <Widget>[
            const Divider(),
            Image.asset("assets/img/esfera.png"),
            const Divider(),
            TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Raio (m)'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  value.replaceAll(',', '.');
                  setState(() {
                    _iRaio = double.parse(value);
                    realizaCalculos();
                  });
                }
              }
            ),
            const Divider(),
            Text('Área da Superfície (Total): ${_iAreaTotal}m'),
            const Divider(),
            Text('Volume: ${_iVolume} metros cúbicos'),
          ],
        )
      )
    );
  }
}