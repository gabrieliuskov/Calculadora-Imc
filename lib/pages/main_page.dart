import 'package:calculadora_imc/models/classifica_imc.dart';
import 'package:calculadora_imc/models/pessoa.dart';
import 'package:calculadora_imc/pages/registro_page.dart';
import 'package:calculadora_imc/repositories/imc.dart';
import 'package:calculadora_imc/shared/text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var pessoa = Pessoa();
  var imcRepository = ImcRepository();

  var pesoController = TextEditingController();
  var alturaController = TextEditingController();

  var _imcs = <Pessoa>[];
  Pessoa lastImc = Pessoa();
  void loadImc() async {
    _imcs = await imcRepository.listaImc();
    if (_imcs.isNotEmpty) {
      lastImc = _imcs[_imcs.length - 1];
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadImc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 5,
            title: const Text(
              "Calculadora IMC",
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListView(
            children: [
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.indigo)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext bc) =>
                                RegistroImcPage(imcRepository: imcRepository)));
                  },
                  child: const Text("Registro de IMC",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white))),
              const Divider(),
              const Center(
                  child: Text(
                "Calculo de IMC",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              )),
              const TextLabel(texto: "Insira seu peso (kg):"),
              TextField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (value == "") {
                    pessoa.setPeso = 0;
                  } else {
                    pessoa.setPeso = int.parse(value);
                  }
                },
              ),
              const TextLabel(texto: "Insira sua altura (cm):"),
              TextField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (value == "") {
                    pessoa.setAltura = 0;
                  } else {
                    pessoa.setAltura = int.parse(value);
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.indigo)),
                  onPressed: () {
                    if (pessoa.getPeso == 0 || pessoa.getPeso == null || pesoController.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Peso inválido! Peso = ${pesoController.text}")));
                      return;
                    }

                    if (pessoa.getAltura == 0 || pessoa.getAltura == null || alturaController.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Altura inválida! Altura = ${alturaController.text}")));
                      return;
                    }
                    pesoController.text = "";
                    alturaController.text = "";
                    pessoa.calculaImc();
                    pessoa.classificacao = ClassificaImc.classificaImc(
                        double.parse(pessoa.getImc));
                    imcRepository.adicionaImc(pessoa);
                    loadImc();
                  },
                  child: const Text(
                    "Calcular",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  )),
              Container(
                child: lastImc.getClasse == ""
                    ? const Center(
                        child: SizedBox(),
                      )
                    : Card(
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                            "IMC: ${lastImc.getImc}\nAltura: ${lastImc.getAltura}\nPeso: ${lastImc.getPeso}\nClassificação: ${lastImc.getClasse}"),
                      ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
