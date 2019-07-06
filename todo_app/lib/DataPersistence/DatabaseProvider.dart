import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

import './TodoItem.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory applicationDirectory = await getApplicationDocumentsDirectory();
    String path = join(applicationDirectory.path, 'TodoList.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE TodoList ( id INTEGER PRIMARY KEY, title TEXT, description TEXT, priority TEXT) ');
    });
  }

  newTodoItem(TodoItem todoItem) async {
    final db = await database;
    var res = await db.insert('TodoList', todoItem.toJSON());
    return res;
  }

  getTodoItem(int id) async {
    final db = await database;
    var res = await db.query('TodoList', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? TodoItem.fromJSON(res.first) : Null;
  }

  deleteTodoItem(int id) async {
    final db = await database;
    db.delete('TodoList', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TodoItem>> getAll() async {
    final db = await database;
    var res = await db.query('TodoList');
    
    
    return List.generate(res.length, (i) {
      
      return TodoItem(
          id: res[i]['id'],
          title: res[i]['title'],
          description: res[i]['description'],
          priority: res[i]['priority']);
    });
  }
}
