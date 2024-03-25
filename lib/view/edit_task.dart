import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/controller.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final String? id;
  EditScreen({Key? key, this.title, this.description, this.id})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final getPro = Provider.of<TodoController>(context, listen: false);
    getPro.titleC.text = widget.title!;
    getPro.descriptionC.text = widget.description!;
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<TodoController>(context, listen: false);
    return Scaffold(
        body: Column(
      children: [
        TextFormField(
          controller: pro.titleC,
          decoration: InputDecoration(label: Text("title")),
        ),
        TextFormField(
          controller: pro.descriptionC,
          decoration: InputDecoration(label: Text("description")),
          minLines: 1,
          maxLines: 8,
        ),
        ElevatedButton(
            onPressed: () async {
              await pro.editTask(widget.id!);
              Navigator.of(context).pop();
            },
            child: Text('submit'))
      ],
    ));
  }
}
