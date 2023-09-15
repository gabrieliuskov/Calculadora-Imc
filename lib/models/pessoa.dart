import 'package:flutter/material.dart';

class Pessoa {
  final String _id = UniqueKey().toString();
  int _peso = 0;
  int _altura = 0;
  double _imc = 0;
  var _classe = "";

  Pessoa();

  get getId => _id;

  get getPeso => _peso;

  set setPeso(int peso) {
    _peso = peso;
  }

  get getAltura => _altura;

  set setAltura(int altura) {
    _altura = altura;
  }

  void calculaImc() {
    var altura = _altura / 100;
    _imc = _peso / (altura * altura);
  }

  get getImc => _imc.toStringAsFixed(2);

  set classificacao(String classe){
    _classe = classe;
  }

  get getClasse => _classe;
}
