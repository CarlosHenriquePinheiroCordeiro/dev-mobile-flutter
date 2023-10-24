import 'package:flutter/material.dart';

class CalculoPiramide extends StatefulWidget {
  _CalculoPiramide createState() => _CalculoPiramide();
}

class _CalculoPiramide extends State {
  var _iLado             = 0.0;
  var _iAltura           = 0.0;
  var _iAreaBase         = 0.0;
  var _iAreaLateral      = 0.0;
  var _iAreaLateralTotal = 0.0;
  var _iAreaTotal        = 0.0;
  var _iVolume           = 0.0;
  Widget build(BuildContext context) {

    void realizaCalculos() {
      _iAreaBase         = _iLado*_iLado;
      _iAreaLateral      = (_iLado*_iAltura)/2;
      _iAreaLateralTotal = _iAreaLateral*4;
      _iAreaTotal        = _iAreaBase+_iAreaLateralTotal;
      _iVolume           = (_iAreaBase*_iAltura)/3;
    }

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Piramide Quadrangular')),
        body: Column(
          children: <Widget>[
            const Divider(),
            Image.asset("assets/img/piramide.png"),
            const Divider(),
            TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Lado (m)'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  value.replaceAll(',', '.');
                  setState(() {
                    _iLado = double.parse(value);
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
            Text('Área de uma lateral: ${_iAreaLateral}m'),
            const Divider(),
            Text('Área Lateral Total: ${_iAreaLateralTotal}m'),
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