class ConfiguracoesModel {
  int? _peso;
  int? _altura;

  ConfiguracoesModel(this._peso, this._altura);
  ConfiguracoesModel.vazio() {
    _peso = 0;
    _altura = 0;
  }

  int get peso => _peso ?? 0;
  int get altura => _altura ?? 0;

  set peso(int peso) {
    _peso = peso;
  }

  set altura(int altura) {
    _altura = altura;
  }
}
