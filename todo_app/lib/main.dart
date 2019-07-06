import 'package:flutter/material.dart';
import './pages/ListPage.dart';
import './pages/TodoCreate.dart';
import './pages/TodoDetails.dart';
import './DataPersistence/DatabaseProvider.dart';
import './DataPersistence/TodoItem.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override 
  State<StatefulWidget> createState(){
    return _MyAppState();
  }
  
  
}

class _MyAppState extends State{
  
  Future<List<TodoItem>> _todoItems = DatabaseProvider.db.getAll();
 
  
  void _removeTodo(int id){
    setState(() {
      DatabaseProvider.db.deleteTodoItem(id);
      _todoItems =DatabaseProvider.db.getAll();
    });
  }
  void _addTodo(Map<String, dynamic> todoItem){
    
    TodoItem newTodoItem =TodoItem(title:todoItem['title'], description: todoItem['description'], priority: todoItem['priority'] );

    
    setState(() {
      
       DatabaseProvider.db.newTodoItem(newTodoItem); 
       _todoItems =DatabaseProvider.db.getAll();
     });
  }

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return MaterialApp(debugShowCheckedModeBanner: false, onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements =
            settings.name.split('/'); 
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'todo') {
          


          return MaterialPageRoute<bool>(builder: (BuildContext context) {
            return TodoDetails(
                pathElements[2], pathElements[3], pathElements[4]);
          });
        }},
      
      routes: {
        '/': (BuildContext context){
        return ListPage(_todoItems, _removeTodo, _addTodo);},
         
           '/addTodo':(BuildContext context){
             return TodoCreate(_addTodo);
           }
      
         
    }, theme: ThemeData(brightness: Brightness.light, ),
    );
  }
}