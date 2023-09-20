import 'package:calculadora_imc/pages/configuracoes_page.dart';
import 'package:calculadora_imc/pages/registro_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                  child: Image.network(
                      "https://hermes.digitalinnovation.one/assets/diome/logo.png")),
              accountName: const Text("Gabriel Iuskov"),
              accountEmail: const Text("iuskovgabriel@gmal.com")),
          InkWell(
            child:Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.history),
                  SizedBox(width: 10,),
                  Text("Registro de IMC", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                ],
              ),
            ),

            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistroImcPage()));
            },
          ),
          const Divider(),

          InkWell(
            child:Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 10,),
                  Text("Configurações", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                ],
              ),
            ),

            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfiguracoesPage()));
            },
          ),
        ],
      ),
    );
  }
}
