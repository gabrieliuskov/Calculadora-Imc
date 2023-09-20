import 'package:hive/hive.dart';
part 'pessoa_model.g.dart';

@HiveType(typeId: 0)
class PessoaModel extends HiveObject{
  @HiveField(0)
  int? _peso;

  @HiveField(1)
  int? _altura;

  @HiveField(2)
  double? _imc;

  @HiveField(3)
  String? _classe;

  @HiveField(4)
  int _id;

  PessoaModel(this._id,this._peso, this._altura, this._imc, this._classe);
  
  get getPeso => _peso;

  set setPeso(int peso) {
    _peso = peso;
  }

  get getId => _id;

  set setId(int id) {
    _id = id;
  }

  get getAltura => _altura;

  set setAltura(int altura) {
    _altura = altura;
  }

  void calculaImc() {
    var altura = _altura! / 100;
    _imc = _peso! / (altura * altura);
  }

  get getImc => _imc!.toStringAsFixed(2);

  set classificacao(String classe) {
    _classe = classe;
  }

  get getClasse => _classe;
}
