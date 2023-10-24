import 'package:flutter/material.dart';

class CalculoCubo extends StatefulWidget {
  _CalculoCubo createState() => _CalculoCubo();
}

class _CalculoCubo extends State {
  var _iAresta      = 0.0;
  var _iAreaBase    = 0.0;
  var _iAreaLateral = 0.0;
  var _iAreaTotal   = 0.0;
  var _iVolume      = 0.0;
  Widget build(BuildContext context) {

    void realizaCalculos() {
      _iAreaBase    = _iAresta*_iAresta;
      _iAreaLateral = _iAreaBase*4;
      _iAreaTotal   = _iAreaBase*6;
      _iVolume      = _iAreaBase*_iAresta;
    }

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Cubo')),
        body: Column(
          children: <Widget>[
            const Divider(),
            Image.asset("assets/img/cubo.png"),
            const Divider(),
            TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Aresta (m)'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  value.replaceAll(',', '.');
                  setState(() {
                    _iAresta = double.parse(value);
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