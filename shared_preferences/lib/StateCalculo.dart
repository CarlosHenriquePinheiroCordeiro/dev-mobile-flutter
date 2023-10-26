import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StateCalculo extends State {

  @override
  void initState() {
    super.initState();
    carregarValores().then((value) => {
      setState(() => 
        realizaCalculos()
      )
    });
  }

  Future<void> carregarValores() async {}

  void realizaCalculos() {}

  void setValorSP(String sChave, double iValor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble(sChave, iValor);
    });
  }


}