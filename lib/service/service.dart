import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/controller/model/model.dart';

class TodoService {
  // Future<List<TodoModel>> fetchData() async {
  //   final responce = await http
  //       .get(Uri.parse("https://65b9ee13b4d53c066551a550.mockapi.io/Todo_App"));
  //   try {
  //     // if (responce.statusCode == 200) {
  //     //   final data = jsonDecode(responce.body);
  //     //   return data;
  //     // }
  //     return (responce.body as List).map((e) => TodoModel.fromJson(e)).toList();
  //   } catch (e) {
  //     throw Exception("failed to fetch");
  //   }
  // }
  final Dio _dio = Dio();
  final String _endpoint =
      'https://65b9ee13b4d53c066551a550.mockapi.io/Todo_App';
  Future<List<TodoModel>> fetchData() async {
    try {
      final Response response = await _dio.get(_endpoint);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => TodoModel.fromJson(e))
            .toList();
      } else {
        throw Exception('failed to load tasks');
      }
    } catch (e) {
      log('$e');
      throw Exception('failed to fetch');
    }
  }

  Future<void> createTask(TodoModel task) async {
    try {
      await _dio.post(_endpoint, data: task.toJson());
    } catch (e) {
      throw Exception("failed");
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _dio.delete('$_endpoint/$id');
    } catch (e) {
      log('error deleting task $e');
      throw Exception(e);
    }
  }

  Future<void> editTask(TodoModel value, String id) async {
    try {
      await _dio.put('$_endpoint/$id', data: value.toJson());
    } catch (e) {
      log('error$e');
    }
  }
}
