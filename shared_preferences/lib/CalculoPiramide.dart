import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_splashscreen_assets/StateCalculo.dart';

class CalculoPiramide extends StatefulWidget {
  _CalculoPiramide createState() => _CalculoPiramide();
}

class _CalculoPiramide extends StateCalculo {

  var _iLado             = 0.0;
  var _sKeyLado          = 'ladoPiramide';
  var _iAltura           = 0.0;
  var _sKeyAltura        = 'alturaPiramide';
  var _iAreaBase         = 0.0;
  var _iAreaLateral      = 0.0;
  var _iAreaLateralTotal = 0.0;
  var _iAreaTotal        = 0.0;
  var _iVolume           = 0.0;

  @override
  Future<void> carregarValores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _iLado   = (prefs.getDouble(_sKeyLado) ?? 0);
    _iAltura = (prefs.getDouble(_sKeyAltura) ?? 0);
  }

  @override
  void realizaCalculos() {
    setState(() {
      _iAreaBase         = _iLado*_iLado;
      _iAreaLateral      = (_iLado*_iAltura)/2;
      _iAreaLateralTotal = _iAreaLateral*4;
      _iAreaTotal        = _iAreaBase+_iAreaLateralTotal;
      _iVolume           = (_iAreaBase*_iAltura)/3;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Piramide Quadrangular')),
        body: FutureBuilder<void>(
          future: carregarValores(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  const Divider(),
                  Image.asset("assets/img/piramide.png"),
                  const Divider(),
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Lado (m)'),
                    initialValue: _iLado.toStringAsFixed(2),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        value.replaceAll(',', '.');
                        _iLado = double.parse(value);
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
                        setValorSP(_sKeyLado   , _iLado);
                        setValorSP(_sKeyAltura, _iAltura);
                        realizaCalculos();
                    },
                    child: const Text('Calcular')
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