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

class _TelaLogin extends State<TelaLogin> {
  GlobalKey<FormState> _chaveForm = new GlobalKey<FormState>();

  String? nameLogin = "";
  String? senha     = "";
  var _mostraPrimeiro = true;

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Reserva de mesas CA"),
        ),
        body: Container(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: this._chaveForm,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  onChanged: (String valor) {
                    if (_chaveForm.currentState!.validate()) {
                      setState(() {
                        _mostraPrimeiro = false;
                      });
                    }
                  },
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
                  decoration: const InputDecoration(
                    hintText: "Usuário do SIGAA",
                    labelText: "Usuário"
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.name,
                  onChanged: (String valor) {
                    if (_chaveForm.currentState!.validate()) {
                      setState(() {
                        _mostraPrimeiro = false;
                      });
                    }
                  },
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
                  decoration: const InputDecoration(
                    hintText: "Senha do SIGAA",
                    labelText: "Senha"
                  ),
                ),
                AnimatedCrossFade(
                  duration: const Duration(seconds: 1),
                  crossFadeState: _mostraPrimeiro
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                  firstChild:
                    const Text('Informe os campos para prosseguir'),
                  secondChild: ElevatedButton(
                    child: const Text("Login"),
                    onPressed: () {
                      if (_chaveForm.currentState!.validate()) {
                        _chaveForm.currentState!.save();
                        Navigator.pushNamed(context, '/home');
                      }
                    }
                  )
                ),
              ]
            )
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
      theme: ThemeData(
        brightness: Brightness.dark
      ),
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
            const BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info'
            ),
            const BottomNavigationBarItem(
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

  var _mostraPrimeiro = true;

  Widget FormReserva() {
    return Center(
      child: Form(
        key: this._chaveFormReserva,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Selecione o seu curso:'),
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
                          if (_chaveFormReserva.currentState!.validate()) {
                            setState(() {
                              _mostraPrimeiro = false;
                            });
                          }
                      }
                    ),
                    const Text('Ciência da Computação'),
                    
                    Radio(
                      value: 2,
                      groupValue: _valorRadio,
                      onChanged: (int? valor) {
                          setState(() {
                            _valorRadio = valor;
                          });
                          if (_chaveFormReserva.currentState!.validate()) {
                            setState(() {
                              _mostraPrimeiro = false;
                            });
                          }
                      }
                    ),
                    const Text('Matemática'),

                    Radio(
                      value: 3,
                      groupValue: _valorRadio,
                      onChanged: (int? valor) {
                          setState(() {
                          _valorRadio = valor;
                          });
                          if (_chaveFormReserva.currentState!.validate()) {
                            setState(() {
                              _mostraPrimeiro = false;
                            });
                          }
                      }
                    ),
                    const Text('Pedagogia')
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
                          if (_chaveFormReserva.currentState!.validate()) {
                            setState(() {
                              _mostraPrimeiro = false;
                            });
                          }
                      }
                    ),
                    const Text('Física'),

                    Radio(
                      value: 5,
                      groupValue: _valorRadio,
                      onChanged: (int? valor) {
                          setState(() {
                          _valorRadio = valor;
                          });
                      }
                    ),
                    const Text('Agronomia')
                  ]
                )
              ]
            ),
            const Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Data da reserva:'),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {
                    if (_chaveFormReserva.currentState!.validate()) {
                      setState(() {
                        _mostraPrimeiro = false;
                      });
                    }
                  },
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
            const Divider(),
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
                          if (_chaveFormReserva.currentState!.validate()) {
                            setState(() {
                              _mostraPrimeiro = false;
                            });
                          }
                      }
                    ),
                    Text('Mesa 1 - até 4 cadeiras'),

                    Checkbox(
                      value: _checkMesa2,
                      onChanged: (bool? valor) {
                          setState(() {
                            _checkMesa2 = valor;
                          });
                          if (_chaveFormReserva.currentState!.validate()) {
                            setState(() {
                              _mostraPrimeiro = false;
                            });
                          }
                      }
                    ),
                    Text('Mesa 2 - até 4 cadeiras'),

                    Checkbox(
                      value: _checkMesa3,
                      onChanged: (bool? valor) {
                          setState(() {
                            _checkMesa3 = valor;
                          });
                          if (_chaveFormReserva.currentState!.validate()) {
                            setState(() {
                              _mostraPrimeiro = false;
                            });
                          }
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
                  onChanged: (value) {
                    if (_chaveFormReserva.currentState!.validate()) {
                      setState(() {
                        _mostraPrimeiro = false;
                      });
                    }
                  },
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
                AnimatedCrossFade(
                  duration: const Duration(seconds: 1),
                  crossFadeState: _mostraPrimeiro
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                  firstChild: const Text('Informe os campos acima.'),
                  secondChild: ElevatedButton(
                    child: const Text("Reservar"),
                    onPressed: () {
                      if (_chaveFormReserva.currentState!.validate()) {
                        _chaveFormReserva.currentState!.save();
                        showDialog(
                          context: context,
                          builder: (BuildContext inContext) {
                            return SimpleDialog(
                              title: const Text('Reserva realizada com sucesso!'),
                              children: [
                                SimpleDialogOption(
                                  onPressed: () {
                                  Navigator.pop(inContext);
                                  },
                                  child: const Text('Ok'),
                                )
                              ],
                            );
                          }
                        );
                      }
                    }
                  )
                )
              ]
            ),
          ],
        )
      )
    );
  }
}