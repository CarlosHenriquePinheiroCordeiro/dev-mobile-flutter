import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculoCilindro extends StatefulWidget {
  _CalculoCilindro createState() => _CalculoCilindro();
}

class _CalculoCilindro extends State {
  var _iRaio        = 0.0;
  var _iAltura      = 0.0;
  var _iAreaBase    = 0.0;
  var _iAreaLateral = 0.0;
  var _iAreaTotal   = 0.0;
  var _iVolume      = 0.0;
  Widget build(BuildContext context) {

    void realizaCalculos() {
      _iAreaBase    = pi*(_iRaio*_iRaio);
      _iAreaLateral = 2*pi*_iRaio*_iAltura;
      _iAreaTotal   = (2*_iAreaBase)+_iAreaLateral;
      _iVolume      = _iAreaBase*_iAltura;
    }

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Cilindro')),
        body: Column(
          children: <Widget>[
            const Divider(),
            Image.asset("assets/img/cilindro.png"),
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
            TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Altura (m)'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  value.replaceAll(',', '.');
                  setState(() {
                    _iAltura = double.parse(value);
                    realizaCalculos();
                  });
                }
              }
            ),
            const Divider(),
            Text('Área da Base: ${_iAreaBase}m'),
            const Divider(),
            Text('Área Lateral: ${_iAreaLateral}m'),
            const Divider(),
            Text('Área Total: ${_iAreaTotal}m'),
            const Divider(),
            Text('Volume: ${_iVolume} metros cúbicos'),
          ],
        )
      )
    );
  }
}