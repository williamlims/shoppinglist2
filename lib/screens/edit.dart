import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '/model/shoppinglist.dart';
import 'shoppinglistapp.dart';

void main() {
  runApp( const Edit());
}

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<Edit> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("list");
  String? id;
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController measure;
  late TextEditingController quantityController ;
  late int quantity;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    description = TextEditingController();
    measure = TextEditingController();
    quantityController = TextEditingController();
    quantity = int.tryParse(quantityController.text) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final items = ModalRoute.of(context)!.settings.arguments as ShoppingList;

    id = items.id;
    title.text = items.title;
    description.text = items.description;
    measure.text = items.measure;
    quantityController.text = items.quantity.toString();
    quantity = int.tryParse(items.quantity.toString())!;

    return MaterialApp(
      title: 'Editar item',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Editar item'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Item',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: measure,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Unidade de Medida',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantidade',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    quantity = int.tryParse(text) ?? 0;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (title == "") {
                      showMessage('Item', "Para criar um novo registro, o campo ITEM deve ser preenchido!");
                    } else if (description == ""){
                      showMessage('Descrição', "Para criar um novo registro, o campo DESCRIÇÃO deve ser preenchido!");
                    } else if (measure == ""){
                      showMessage('Medida', "Para criar um novo registro, o campo MEDIDA deve ser preenchido!");
                    } else if (quantityController.text == 0){
                      showMessage('Quantidade', "Para criar um novo registro, o campo QUANTIDADE deve ser um NÚMERO diferente de 0!");
                    } else {
                        await _dbRef.child(id!).update({
                          'title': title.text,
                          'description': description.text,
                          'measure': measure.text,
                          'quantity': quantity,
                        });
                     // }
                      //updateItem(id);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ShoppingListApp()),
                      );
                    }
                  },
                  child: const Text('ATUALIZAR'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _dbRef.child(id!).remove();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ShoppingListApp()),
                    );
                  },
                  child: const Text('DELETAR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showMessage(String titleText, String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(titleText),
          content: Text(text),
        )
    );
  }
}
