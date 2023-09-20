import 'package:calculadora_imc/models/configuracoes_model.dart';
import 'package:calculadora_imc/pages/main_page.dart';
import 'package:calculadora_imc/repositories/configuracoes_repository.dart';
import 'package:calculadora_imc/shared/text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void carregar() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();

    if (configuracoesModel.peso == 0) {
      pesoController.text = "";
    } else{
      pesoController.text = configuracoesModel.peso.toString();
    }
    if (configuracoesModel.altura == 0) {
      alturaController.text = "";
    }else{
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
        appBar: AppBar(
          title: const Text("Configurações"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListView(
            children: [
              const TextLabel(texto: "Peso (kg):"),
              TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    pesoController.text = value.toString();
                  }),
              const TextLabel(texto: "Altura (cm):"),
              TextField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    alturaController.text = value.toString();
                  }),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.indigo)),
                  onPressed: () {
                    configuracoesModel.altura =
                        int.tryParse(alturaController.text) ?? 0;
                    configuracoesModel.peso =
                        int.tryParse(pesoController.text) ?? 0;
                    configuracoesRepository.salvar(configuracoesModel);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
