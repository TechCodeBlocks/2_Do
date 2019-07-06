import 'package:flutter/material.dart';
import './ListSection.dart';
import '../DataPersistence/TodoItem.dart';

class ListPage extends StatelessWidget {
  final Future<List<TodoItem>> todoItems;
  final Function removeItem;
  final Function addItem;

  ListPage(this.todoItems, this.removeItem, this.addItem);

  List<TodoItem> buildList(AsyncSnapshot<List> snapshot) {
    List<TodoItem> myList = [];
    for (TodoItem todoItem in snapshot.data) {
      myList.add(todoItem);
    }
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text('2-Do'),
        ),
        body: FutureBuilder(
            future: todoItems,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Column(children: <Widget>[
                  Text('No 2-do items, click the button to add some'),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/addTodo');
                      },
                      child: Container(
                        color: Colors.blue,
                        child: SizedBox(
                          width: 700,
                          height: 80,
                          child: Center(
                              child: Text(
                            '+',
                            style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      ))
                ]);
              } else {
                return Column(children: <Widget>[
                  Expanded(
                      child: ListSection(
                          buildList(snapshot), removeItem, addItem)),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/addTodo');
                      },
                      child: Container(
                        color: Colors.blue,
                        child: SizedBox(
                          width: 700,
                          height: 80,
                          child: Center(
                              child: Text(
                            '+',
                            style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      ))
                ]);
              }
            }));
  }
}
