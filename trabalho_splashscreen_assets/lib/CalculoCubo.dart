import 'package:flutter/material.dart';

class CalculoCubo extends StatefulWidget {
  CalculoCubo({Key? key}) : super(key:key);
  _CalculoCubo createState() => _CalculoCubo();
}

class _CalculoCubo extends State {
  GlobalKey<FormState> _chaveFormReserva = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Cubo')),
        body: Text('Teste Cubo')
      )
    );
  }
}