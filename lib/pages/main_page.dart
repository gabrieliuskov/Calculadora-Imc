import 'package:calculadora_imc/models/configuracoes_model.dart';
import 'package:calculadora_imc/models/pessoa_model.dart';
import 'package:calculadora_imc/repositories/configuracoes_repository.dart';
import 'package:calculadora_imc/repositories/imc_repository.dart';
import 'package:calculadora_imc/utils/classifica_imc.dart';
import 'package:calculadora_imc/shared/drawer.dart';
import 'package:calculadora_imc/shared/text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var pessoa = PessoaModel(0,0, 0, 0, "");
  late ImcRepository imcRepository;
  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();

  var pesoController = TextEditingController();
  var alturaController = TextEditingController();

  void carregar() async {
    imcRepository = await ImcRepository.carregar();
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();

    if (configuracoesModel.peso == 0) {
      pesoController.text = "";
    } else {
      pesoController.text = configuracoesModel.peso.toString();
    }
    if (configuracoesModel.altura == 0) {
      alturaController.text = "";
    } else {
      alturaController.text = configuracoesModel.altura.toString();
    }
    setState(() {});
  }

  @override
  void initState() {
    carregar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
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
              ),
              const TextLabel(texto: "Insira sua altura (cm):"),
              TextField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.indigo)),
                  onPressed: () {
                    if (pesoController.text == "" || pesoController.text == "0") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Peso inválido! Peso = ${pesoController.text}")));
                      return;
                    }

                    if (alturaController.text == "" || alturaController.text == "0") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Altura inválida! Altura = ${alturaController.text}")));
                      return;
                    }
                    pessoa.setPeso = int.parse(pesoController.text);
                    pessoa.setAltura = int.parse(alturaController.text);
                    pessoa.calculaImc();
                    pessoa.classificacao = ClassificaImc.classificaImc(
                        double.parse(pessoa.getImc));

                    imcRepository.salvar(pessoa);

                    setState(() {});
                  },
                  child: const Text(
                    "Calcular",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  )),
              Container(
                child: pessoa.getClasse == ""
                    ? const Center(
                        child: SizedBox(),
                      )
                    : Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Text(
                              "IMC: ${pessoa.getImc}\nAltura: ${pessoa.getAltura}\nPeso: ${pessoa.getPeso}\nClassificação: ${pessoa.getClasse}"),
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
