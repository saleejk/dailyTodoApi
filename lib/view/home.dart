import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/controller.dart';
import 'package:flutter_application_1/view/add_data.dart';
import 'package:flutter_application_1/view/edit_task.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final todopro = Provider.of<TodoController>(context, listen: false);
    print(todopro.todoList);
    return Scaffold(
      body: Consumer<TodoController>(builder: (context, pro, child) {
        todopro.getData();
        return todopro.todoList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (ctx, index) {
                  final reversedIndex = pro.todoList.length - index - 1;
                  final list = pro.todoList[reversedIndex];
                  print("heyyyy,${list.description.runtimeType}");

                  return ListTile(
                    // trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    //   IconButton(
                    //       onPressed: () {
                    //         pro.editTask(list.id.toString());
                    //       },
                    //       icon: Icon(Icons.edit)),
                    //   IconButton(
                    //       onPressed: () {
                    //         pro.deleteTask(list.id.toString());
                    //       },
                    //       icon: Icon(Icons.delete))
                    // ]),
                    trailing: PopupMenuButton<String>(
                      onSelected: (result) async {
                        if (result == "Delete") {
                          await todopro.deleteTask(list.id.toString());
                        } else if (result == "Edit") {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => EditScreen(
                              title: list.title,
                              description: list.description,
                              id: list.id,
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem(
                          child: Text('Edit'),
                          value: "Edit",
                        ),
                        PopupMenuItem(
                          child: Text('Delete'),
                          value: "Delete",
                        ),
                      ],
                    ),
                    title: Text(list.title.toString()),
                    subtitle: Text(list.description.toString()),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider();
                },
                itemCount: pro.todoList.length);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
