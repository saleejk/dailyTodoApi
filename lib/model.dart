import 'dart:convert';

class TodoModel {
  String? title;
  String? description;
  String? id;
  TodoModel({this.title, this.description, this.id});
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        title: json["title"], description: json["description"], id: json["id"]);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["title"] = title;
    data["description"] = description;
    data["id"] = id;
    return data;
  }
}
