import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Reservas Mesa CA',
    initialRoute: '/',
    routes: {
      '/': (context) => TelaLogin(),
      '/home': (context) => TelaHome()
    },
  ));
}

class TelaLogin extends StatefulWidget {
  TelaLogin({Key? key}) : super(key: key);
  _TelaLogin createState() => _TelaLogin();
}

class _TelaLogin extends State {
  GlobalKey<FormState> _chaveForm = new GlobalKey<FormState>();

  String? nameLogin = "";
  String? senha     = "";

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Reserva de mesas CA"),
        ),
        body: Container(
          padding: EdgeInsets.all(50.0),
          child: Form(
            key: this._chaveForm,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (String? valor) {
                    if (valor == null) {
                      return "Informe o usuário";
                    }
                    if (valor.isEmpty) {
                      return "Informe o usuário";
                    }
                    return null;
                  },
                  onSaved: (String? valor) {
                    this.nameLogin = valor;
                  },
                  decoration: InputDecoration(
                    hintText: "Usuário do SIGAA",
                    labelText: "Usuário"
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.name,
                  validator: (String? valor) {
                    if (valor == null) {
                      return "Informe a sua senha";
                    }
                    if (valor.isEmpty) {
                      return "Informe a sua senha";
                    }
                    return null;
                  },
                  onSaved: (String? valor) {
                    this.senha = valor;
                  },
                  decoration: InputDecoration(
                    hintText: "Senha do SIGAA",
                    labelText: "Senha"
                  ),
                ),
                ElevatedButton(
                  child: Text("Login"),
                  onPressed: () {
                    if (_chaveForm.currentState!.validate()) {
                      _chaveForm.currentState!.save();
                      Navigator.pushNamed(context, '/home');
                    }
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TelaHome extends StatefulWidget {
  TelaHome({Key? key}) : super(key:key);
  _TelaHome createState() => _TelaHome();
}

class _TelaHome extends State {
  var _paginaAtual = 0;
  var _titulos = ["Como reservar?", "Realizar reserva"];
  var _stepAtual = 0;
  int? _valorRadio = 0;
  bool? _checkMesa1 = false;
  bool? _checkMesa2 = false;
  bool? _checkMesa3 = false;
  bool? _checkMesa4 = false;
  GlobalKey<FormState> _chaveFormReserva = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(_titulos[_paginaAtual])),
        body: IndexedStack(
          index: _paginaAtual,
          children: <Widget>[
            StepperInfo(),
            FormReserva()
          ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Reservar'
            )
          ],
          currentIndex: _paginaAtual,
          onTap: (int indice) {
            setState(() {
              _paginaAtual = indice;
            });
          },
        ),
      ),
    );
  }

  Widget StepperInfo() {
    return Stepper(
      type: StepperType.vertical,
      currentStep: _stepAtual,
      onStepContinue: _stepAtual < 3 ? () => setState(() {_stepAtual += 1;}) : null,
      onStepCancel:   _stepAtual > 0 ? () => setState(() {_stepAtual -= 1;}) : null,
      onStepTapped: (step) => setState(() {
        _stepAtual = step;
      }),
      steps: [
        Step(
          title: Text('1. Curso'),
          content: Text('Selecione o seu curso'),
          isActive: true
        ),
        Step(
          title: Text('2. Horário'),
          content: Text('Informe a data de utilização da(s) mesa(s)'),
          isActive: true
        ),
        Step(
          title: Text('3. Mesas'),
          content: Text('Selecione as mesas a serem utilizadas'),
          isActive: true
        ),
        Step(
          title: Text('4. Pessoas'),
          content: Text('Informe a quantidade de pessoas da reserva'),
          isActive: true
        )
      ],
    );
  }

  Widget FormReserva() {
    return Center(
      child: Form(
        key: this._chaveFormReserva,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Selecione o seu curso:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _valorRadio,
                      onChanged: (int? valor) {
                          setState(() {
                          _valorRadio = valor;
                          });
                      }
                    ),
                    Text('Ciência da Computação'),
                    
                    Radio(
                      value: 2,
                      groupValue: _valorRadio,
                      onChanged: (int? valor) {
                          setState(() {
                          _valorRadio = valor;
                          });
                      }
                    ),
                    Text('Matemática'),

                    Radio(
                      value: 3,
                      groupValue: _valorRadio,
                      onChanged: (int? valor) {
                          setState(() {
                          _valorRadio = valor;
                          });
                      }
                    ),
                    Text('Pedagogia')
                  ]
                )
              ]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 4,
                      groupValue: _valorRadio,
                      onChanged: (int? valor) {
                          setState(() {
                          _valorRadio = valor;
                          });
                      }
                    ),
                    Text('Física'),

                    Radio(
                      value: 5,
                      groupValue: _valorRadio,
                      onChanged: (int? valor) {
                          setState(() {
                          _valorRadio = valor;
                          });
                      }
                    ),
                    Text('Agronomia')
                  ]
                )
              ]
            ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Data da reserva:'),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  validator: (String? valor) {
                      if (valor == null) {
                      return "Informe a data da reserva";
                      }
                      if (valor.isEmpty) {
                      return "Informe a data da reserva";
                      }
                      return null;
                  },
                )
              ],
            ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Selecione a(s) mesas:   '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _checkMesa1,
                      onChanged: (bool? valor) {
                          setState(() {
                          _checkMesa1 = valor;
                          });
                      }
                    ),
                    Text('Mesa 1 - até 4 cadeiras'),

                    Checkbox(
                      value: _checkMesa2,
                      onChanged: (bool? valor) {
                          setState(() {
                          _checkMesa2 = valor;
                          });
                      }
                    ),
                    Text('Mesa 2 - até 4 cadeiras'),

                    Checkbox(
                      value: _checkMesa3,
                      onChanged: (bool? valor) {
                          setState(() {
                          _checkMesa3 = valor;
                          });
                      }
                    ),
                    Text('Mesa 3 - até 6 cadeiras e 1 PC'),
                  ],
                )
              ],
            ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Para quantas pessoas?'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (String? valor) {
                    if (valor == null) {
                    return "Informe a quantidade de pessoas";
                    }
                    if (valor.isEmpty) {
                    return "Informe a quantidade de pessoas";
                    }
                    return null;
                  }
                ),
                ElevatedButton(
                  child: Text("Reservar"),
                  onPressed: () {
                    if (_chaveFormReserva.currentState!.validate()) {
                      _chaveFormReserva.currentState!.save();
                      showDialog(
                        context: context,
                        builder: (BuildContext inContext) {
                          return SimpleDialog(
                            title: Text('Reserva realizada com sucesso!'),
                            children: [
                              SimpleDialogOption(
                                onPressed: () {
                                Navigator.pop(inContext);
                                },
                                child: Text('Ok'),
                              )
                            ],
                          );
                        }
                      );
                    }
                  }
                )
              ]
            ),
          ],
        )
      )
    );
  }
}