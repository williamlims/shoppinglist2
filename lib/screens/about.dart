import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const About());
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Sobre',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sobre'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0, bottom: 10.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Bem-vindo ao nosso aplicativo de Lista de Compras!'
                  'Este aplicativo foi desenvolvido para simplificar o '
                  'gerenciamento das suas compras do dia a dia, oferecendo '
                  'uma experiência prática e intuitiva para criar e gerenciar '
                  'suas listas de forma rápida e eficiente. Aqui está um resumo '
                  'das principais funcionalidades:\n'),
              Text('Inserir Itens, Lista de Itens, Editar Itens e Tela Sobre.\n'),
              Text('Nosso principal objetivo é ajudar você a gerenciar suas compras '
                  'de forma simples e sem complicações. Com uma interface limpa, '
                  'fácil de usar e repleta de funcionalidades úteis, o aplicativo '
                  'foi pensado para quem quer economizar tempo e evitar esquecimentos '
                  'na hora de fazer compras.\n'),
              Text('Esperamos que você aproveite ao máximo o aplicativo e que ele faça '
                  'parte do seu dia a dia para tornar suas compras mais '
                  'organizadas e eficientes!\n'),
            ],
          ),
        ),
      ),
    );
  }
}