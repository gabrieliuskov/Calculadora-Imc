import 'package:calculadora_imc/models/configuracoes_model.dart';
import 'package:calculadora_imc/repositories/imc_repository.dart';
import 'package:hive/hive.dart';

class ConfiguracoesRepository {
  static late Box _box;

  ConfiguracoesRepository._criar();

  static Future<ConfiguracoesRepository> carregar() async{
    if(Hive.isBoxOpen(Chaves.chaveConfiguracoes.toString())){
      _box = Hive.box(Chaves.chaveConfiguracoes.toString());
    }else{
      _box = await Hive.openBox(Chaves.chaveConfiguracoes.toString());
    }
    return ConfiguracoesRepository._criar();
  }

  salvar(ConfiguracoesModel configuracoesModel){
    _box.put(Chaves.chaveConfiguracoes.toString(), {
      "peso": configuracoesModel.peso,
      "altura": configuracoesModel.altura
    });
  }

  ConfiguracoesModel obterDados(){
    var dados  = _box.get(Chaves.chaveConfiguracoes.toString());

    if (dados == null){
      return ConfiguracoesModel.vazio();
    }
    return ConfiguracoesModel(dados["peso"], dados["altura"]);
  }
}