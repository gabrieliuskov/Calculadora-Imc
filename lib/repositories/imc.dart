import 'package:calculadora_imc/models/pessoa.dart';

class ImcRepository{
  final List<Pessoa> _imcs = [];

  void adicionaImc(Pessoa pessoa) async{
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.add(pessoa);
  }

  void deletaImc(Pessoa pessoa) async{
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.remove(_imcs.where((imc) => imc.getId == pessoa.getId).first);
  }

  Future<List<Pessoa>> listaImc() async{
    await Future.delayed(const Duration(milliseconds: 100));
    return _imcs;
  }
}