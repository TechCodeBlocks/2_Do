import 'package:flutter/material.dart';

class TodoDetails extends StatelessWidget {
  String _title;
  String _description;
  String _priority;
  TodoDetails(this._title, this._description, this._priority);

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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          backgroundColor: getColor(_priority),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Text(
                _description,
                style: TextStyle(fontSize: 24),
              ),
              padding: EdgeInsets.all(32),
            ),
          ],
        ));
  }
}
