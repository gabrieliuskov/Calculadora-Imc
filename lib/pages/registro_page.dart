import 'package:calculadora_imc/models/pessoa.dart';
import 'package:calculadora_imc/repositories/imc.dart';
import 'package:flutter/material.dart';

class RegistroImcPage extends StatefulWidget {
  final ImcRepository imcRepository;
  const RegistroImcPage({super.key, required this.imcRepository});

  @override
  State<RegistroImcPage> createState() => _RegistroImcPageState();
}

class _RegistroImcPageState extends State<RegistroImcPage> {
  var _imcs = <Pessoa>[];
  void loadImc() async {
    _imcs = await widget.imcRepository.listaImc();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadImc();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de IMC"),),
      body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _imcs.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var imc = _imcs[index];
                    return Card(
                      shadowColor: Colors.indigo,
                      elevation: 8,
                      child: ListTile(
                        title: Text(
                            "IMC: ${imc.getImc}\nAltura: ${imc.getAltura}\nPeso: ${imc.getPeso}\nClassificação: ${imc.getClasse}"),
                      ),
                    );
                  }),
    );
  }
}