import 'package:calculadora_imc/models/pessoa_model.dart';
import 'package:calculadora_imc/repositories/imc_repository.dart';
import 'package:flutter/material.dart';

class RegistroImcPage extends StatefulWidget {
  const RegistroImcPage({super.key});

  @override
  State<RegistroImcPage> createState() => _RegistroImcPageState();
}

class _RegistroImcPageState extends State<RegistroImcPage> {
  late ImcRepository imcRepository;
  var _imcs = <PessoaModel>[];
  void loadImc() async {
    imcRepository = await ImcRepository.carregar();
    _imcs = imcRepository.obterDados();
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
                    print(imc);
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