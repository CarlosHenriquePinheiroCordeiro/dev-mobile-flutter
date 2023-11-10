import 'dart:io';

import 'package:exemplo/Pessoa.dart';
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
  Pessoa pessoa = Pessoa(idade: null, name: null);
  late Database _database;
  late StoreRef<int, Map<String, dynamic>> _store;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = '${appDocDir.path}/devMobile.db';

    DatabaseFactory dbFactory = databaseFactoryIo;
    _database = await dbFactory.openDatabase(dbPath);
    _store = intMapStoreFactory.store('my_store');
  }

  Future<void> _insertData(String? name, int? idade) async {
    await _store.add(_database, {'name': name, 'age': idade});
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> _getAllData() async {
    final snapshots = await _store.find(_database);
    return snapshots.map((snapshot) {
      var data = Map<String, dynamic>.from(snapshot.value); // Criar cópia modificável
      data['key'] = snapshot.key;
      return data;
    }).toList();
  }

  Future<void> _deleteData(int key) async {
    await _store.record(key).delete(_database);
    setState(() {});
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
        title: const Text('Sembast Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) => pessoa.name = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                onChanged: (value) => pessoa.idade = int.parse(value),
              ),
              ElevatedButton(
                onPressed: () {
                  _insertData(pessoa.name, pessoa.idade);
                },
                child: const Text('Adicionar Dados ao Banco de Dados'),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _getAllData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Erro ao recuperar dados');
                    } else {
                      var dataList = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: dataList!.length,
                          itemBuilder: (context, index) {
                            var data = dataList[index];
                            return ListTile(
                              title: Text(
                                'Nome: ${data['name']}, Idade: ${data['age']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteData(data['key']); 
                              },
                            ),
                            );
                          },
                        ),
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}