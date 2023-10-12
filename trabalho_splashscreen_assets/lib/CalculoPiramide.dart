import 'package:flutter/material.dart';

class CalculoPiramide extends StatefulWidget {
  CalculoPiramide({Key? key}) : super(key:key);
  _CalculoPiramide createState() => _CalculoPiramide();
}

class _CalculoPiramide extends State {
  GlobalKey<FormState> _chaveFormReserva = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Piramide')),
        body: Text('Teste Piramide')
      )
    );
  }
}