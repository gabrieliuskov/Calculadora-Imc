class ClassificaImc {
  static String classificaImc(double imc) {
    switch (imc) {
      case < 16:
        return "Magreza Grave";

      case < 17:
        return "Magreza Moderada";

      case < 18.5:
        return "Magreza Leve";

      case < 25:
        return "Saudável";

      case < 30:
        return "Sobrepeso";

      case < 35:
        return "Obesidade";

      case < 40:
        return "Obesidade severa";

      default:
        return "Obesidade mórbida";
    }
  }
}
