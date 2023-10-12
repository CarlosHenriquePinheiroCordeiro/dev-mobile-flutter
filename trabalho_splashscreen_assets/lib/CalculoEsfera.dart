import 'package:flutter/material.dart';

class CalculoEsfera extends StatefulWidget {
  CalculoEsfera({Key? key}) : super(key:key);
  _CalculoEsfera createState() => _CalculoEsfera();
}

class _CalculoEsfera extends State {
  GlobalKey<FormState> _chaveFormReserva = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Esfera')),
        body: Text('Teste Esfera')
      )
    );
  }
}