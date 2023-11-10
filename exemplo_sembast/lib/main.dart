import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Database _database;
  late StoreRef<int, Map<String, dynamic>> _store;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = '${appDocDir.path}/my_database.db';

    DatabaseFactory dbFactory = databaseFactoryIo;
    _database = await dbFactory.openDatabase(dbPath);
    _store = intMapStoreFactory.store('my_store');
  }

  Future<void> _insertData() async {
    var key = await _store.add(_database, {'name': 'John', 'age': 25});
    print('Data inserted with key: $key');
  }

  Future<Map<String, dynamic>?> _getData(int key) async {
    return await _store.record(key).get(_database);
  }


  @override
  void dispose() async {
    await _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sembast Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _insertData,
              child: Text('Adicionar Dados ao Banco de Dados'),
            ),
            SizedBox(height: 20),
            FutureBuilder<Map<String, dynamic>?>(
              future: Future.value(_getData(1)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Erro ao recuperar dados');
                  } else {
                    var data = snapshot.data;
                    return Text(
                      'Nome: ${data?['name']}, Idade: ${data?['age']}',
                      style: TextStyle(fontSize: 16),
                    );
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
