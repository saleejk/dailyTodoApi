// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   List<dynamic> productList = [];

//   Future fetchData() async {
//     final responce =
//         await http.get(Uri.parse("https://fakestoreapi.com/products"));
//     try {
//       if (responce.statusCode == 200) {
//         setState(() {
//           productList = jsonDecode(responce.body);
//         });
//       }
//     } catch (e) {
//       throw Exception('failed to load todo');
//     }
//   }

//   void initState() {
//     // TODO: implement initState
//     fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.separated(
//           itemBuilder: (ctx, index) {
//             Map<String, dynamic> products = productList[index];
//             return ListTile(
//               title: Text(
//                 products['title'],
//               ),
//             );
//           },
//           separatorBuilder: (ctx, index) {
//             return Divider();
//           },
//           itemCount: 4),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/controller.dart';
import 'package:flutter_application_1/view/add_data.dart';
import 'package:flutter_application_1/view/edit_task.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final todopro = Provider.of<TodoController>(context, listen: false);
    return Scaffold(
      body: Consumer<TodoController>(builder: (context, pro, child) {
        todopro.getData();
        return todopro.todoList.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (ctx, index) {
                  final reversedIndex = pro.todoList.length - index - 1;
                  final list = pro.todoList[reversedIndex];
                  print("heyyyy,${list.description.runtimeType}");

                  return ListTile(
                    trailing: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditScreen(),
                              ));
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              pro.deleteTask(list.id.toString());
                            },
                            icon: Icon(Icons.delete))
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
