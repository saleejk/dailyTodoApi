import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';
import 'package:flutter_application_1/service.dart';
import 'package:http/http.dart' as http;

class TodoController extends ChangeNotifier {
  TextEditingController titleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  List<TodoModel> todoList = [];
  TodoService ts = TodoService();
  Future<void> getData() async {
    try {
      await Future.delayed(Duration(seconds: 2));

      todoList = await ts.fetchData();
      notifyListeners();
    } catch (e) {
      log('failed to fetch $e');
      rethrow;
    }
  }

  Future<void> createTask() async {
    try {
      await ts.createTask(TodoModel(
        title: titleC.text,
        description: descriptionC.text,
      ));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  deleteTask(String id) async {
    try {
      await ts.deleteTask(id);
      notifyListeners();
    } catch (e) {}
  }

  editTask(String id) async {
    try {
      await ts.editTask(
          TodoModel(title: titleC.text, description: descriptionC.text), id);
    } catch (e) {
      throw e;
    }
  }
}
