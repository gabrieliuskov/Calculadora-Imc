import 'package:calculadora_imc/models/pessoa_model.dart';
import 'package:calculadora_imc/myapp.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(PessoaModelAdapter());
  runApp(const MyApp());
}

