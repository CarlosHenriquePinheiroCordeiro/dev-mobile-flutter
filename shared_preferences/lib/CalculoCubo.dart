import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_splashscreen_assets/StateCalculo.dart';

class CalculoCubo extends StatefulWidget {
  _CalculoCubo createState() => _CalculoCubo();
}

class _CalculoCubo extends StateCalculo {

  var _iAresta      = 0.0;
  var _sKeyAresta   = 'arestaCubo';
  var _iAreaBase    = 0.0;
  var _iAreaLateral = 0.0;
  var _iAreaTotal   = 0.0;
  var _iVolume      = 0.0;

  @override
  Future<void> carregarValores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _iAresta = (prefs.getDouble(_sKeyAresta) ?? 0);
  }

  @override
  void realizaCalculos() {
    setState(() {
      _iAreaBase    = _iAresta*_iAresta;
      _iAreaLateral = _iAreaBase*4;
      _iAreaTotal   = _iAreaBase*6;
      _iVolume      = _iAreaBase*_iAresta;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Cubo')),
        body: FutureBuilder<void>(
          future: carregarValores(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  const Divider(),
                  Image.asset("assets/img/cubo.png"),
                  const Divider(),
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Aresta (m)'),
                    initialValue: _iAresta.toStringAsFixed(2),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        value.replaceAll(',', '.');
                        _iAresta = double.parse(value);
                      }
                    }
                  ),
                  ElevatedButton(
                    onPressed: () {
                        setValorSP(_sKeyAresta, _iAresta);
                        realizaCalculos();
                    },
                    child: const Text('Calcular')
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