import 'package:calculadora_imc/models/pessoa_model.dart';
import 'package:hive/hive.dart';

enum Chaves { chaveImcNew, chaveConfiguracoes }

class ImcRepository {
  static late Box _box;

  ImcRepository._criar();

  static Future<ImcRepository> carregar() async {
    if (Hive.isBoxOpen(Chaves.chaveImcNew.toString())) {
      _box = Hive.box(Chaves.chaveImcNew.toString());
    } else {
      _box = await Hive.openBox(Chaves.chaveImcNew.toString());
    }

    return ImcRepository._criar();
  }

  void salvar(PessoaModel pessoaModel) {
    var tamanho = _box.values.cast<PessoaModel>().toList().length;
    pessoaModel.setId = tamanho + 1;
    PessoaModel outraPessoa = PessoaModel(pessoaModel.getId, pessoaModel.getPeso, pessoaModel.getAltura, double.parse(pessoaModel.getImc), pessoaModel.getClasse);
    _box.add(outraPessoa);
  }

  List<PessoaModel> obterDados() {
    var pessoas = <PessoaModel>[];
    
    try {
      pessoas = _box.values.cast<PessoaModel>().toList();
    } catch (e) {
      pessoas = <PessoaModel>[];
    }
    return pessoas;
  }
}
