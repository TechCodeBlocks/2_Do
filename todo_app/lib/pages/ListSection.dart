import 'package:flutter/material.dart';
import '../DataPersistence/TodoItem.dart';

class ListSection extends StatelessWidget {
  final List<TodoItem> todoItems;
  final Function removeItem;
  final Function addItem;

  ListSection(this.todoItems, this.removeItem, this.addItem);

  Color getColor(colorValue) {
    switch (colorValue) {
      case 'red':
        {
          return Colors.red;
        }
        break;
      case 'amber':
        {
          return Colors.amber;
        }
        break;
      case 'green':
        {
          return Colors.green;
        }
        break;
    }
    return Colors.white;
  }

  Widget _buildTodoItem(BuildContext context, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              context,
              '/todo/' +
                  todoItems[index].title +
                  '/' +
                  todoItems[index].description +
                  '/' +
                  todoItems[index].priority);
        },
        onDoubleTap: () {
          removeItem(todoItems[index].id);
        },
        child: Card(
            child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 16.0,
                height: 48,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: getColor(todoItems[index].priority)),
                width: 16.0,
                height: 16.0,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                todoItems[index].title,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ])));
  }

  @override
  Widget build(BuildContext context) {
    return todoItems.length > 0
        ? ListView.builder(
            itemBuilder: _buildTodoItem,
            itemCount: todoItems.length,
          )
        : Center(
            child: Text('No Todo Items found, please add some'),
          );
  }
}
