import 'dart:convert';

class TodoItem {
  int id;
  String title;
  String description;
  String priority;

  TodoItem({this.id, this.title, this.description, this.priority});

  factory TodoItem.fromJSON(Map<String, dynamic> json) => new TodoItem(
      id: json['id'], title: json['title'], description: json['description'], priority: json['priority']);

  Map<String, dynamic> toJSON() =>{
  'id': id,
  'title':title,
  'description':description,
  'priority':priority
  };

  }

TodoItem todoItemFromJSON(String str) {
  final jsonData = json.decode(str);
  return TodoItem.fromJSON(jsonData);
}

String todoItemToJSON(TodoItem data) {
  final dyn = data.toJSON();
  return json.encode(dyn);
}
