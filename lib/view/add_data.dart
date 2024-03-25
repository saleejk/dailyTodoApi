import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/controller.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addDataPro = Provider.of<TodoController>(context, listen: false);
    return Scaffold(
        body: Column(
      children: [
        TextFormField(
          controller: addDataPro.titleC,
          decoration: InputDecoration(label: Text("title")),
        ),
        TextFormField(
          controller: addDataPro.descriptionC,
          decoration: InputDecoration(label: Text("description")),
          minLines: 1,
          maxLines: 8,
        ),
        ElevatedButton(
            onPressed: () async {
              addDataPro.createTask();
              Navigator.of(context).pop();
            },
            child: Text('submit'))
      ],
    ));
  }
}
