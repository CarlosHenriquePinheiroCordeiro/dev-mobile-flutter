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
        ),
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
            Text('Agronomia'),
        ]
        ),
        Divider(),
        Row(
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
        ]
        ),
        Text('Selecione a(s) mesas'),
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
        ),
        Divider(),
        Row(
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
        ]
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
    ],
) 