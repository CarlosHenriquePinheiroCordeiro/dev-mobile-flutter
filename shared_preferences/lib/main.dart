import 'package:flutter/material.dart';
import 'CalculoPiramide.dart';
import 'CalculoCubo.dart';
import 'CalculoEsfera.dart';
import 'CalculoCilindro.dart';

void main() {
  runApp(MaterialApp(
    title: 'GeometriaRápida',
    initialRoute: '/',
    routes: {
      '/'        : (context) => const Home(),
      '/piramide': (context) => CalculoPiramide(),
      '/cubo'    : (context) => CalculoCubo(),
      '/esfera'  : (context) => CalculoEsfera(),
      '/cilindro': (context) => CalculoCilindro()
    },
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Geometria Fácil"),
        ),
        body: ListView(
          children: [
            const ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('Selecione uma forma geométrica para realizar cálculos'),
            ),
            ListTile(
              leading: Image.asset("assets/img/piramide.png"),
              title: const Text('Pirâmide Quadrangular'),
              onTap: () => Navigator.pushNamed(context, '/piramide')
            ),
            ListTile(),
            ListTile(
              leading: Image.asset("assets/img/cubo.png"),
              title: const Text('Cubo'),
              onTap: () => Navigator.pushNamed(context, '/cubo')
            ),
            ListTile(),
            ListTile(
              leading: Image.asset("assets/img/esfera.png"),
              title: const Text('Esfera'),
              onTap: () => Navigator.pushNamed(context, '/esfera')
            ),
            ListTile(),
            ListTile(
              leading: Image.asset("assets/img/cilindro.png"),
              title: const Text('Cilindro'),
              onTap: () => Navigator.pushNamed(context, '/cilindro')
            )
          ],
        )
      ),
    );
  }
}