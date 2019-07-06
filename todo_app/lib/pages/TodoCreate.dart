import 'package:flutter/material.dart';

class TodoCreate extends StatefulWidget {
  final Function addItem;
  TodoCreate(this.addItem);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoCreateState(addItem);
  }
}

class _TodoCreateState extends State {
  String _titleValue = '';
  String _descriptionValue = '';
  String colorValue;
  final Function addItem;
  _TodoCreateState(this.addItem);

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
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(title: Text('Add 2-Do Iterm')),
            body: Container(
                margin: EdgeInsets.all(10.0),
                child: ListView(children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: '2-do Title'),
                    onChanged: (String value) {
                      setState(() {
                        _titleValue = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: '2-do Description'),
                    maxLines: 4,
                    onChanged: (String value) {
                      setState(() {
                        _descriptionValue = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Select Priority'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            colorValue = 'red';
                          });
                        },
                      ),
                      RaisedButton(
                        color: Colors.amber,
                        onPressed: () {
                          setState(() {
                            colorValue = 'amber';
                          });
                        },
                      ),
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            colorValue = 'green';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Selected Priority'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: getColor(colorValue),
                    child: SizedBox(
                      width: 32,
                      height: 32,
                    ),
                  ),
                  RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text('Save'),
                      onPressed: () {
                        final Map<String, dynamic> todoItem = {
                          'title': _titleValue,
                          'description': _descriptionValue,
                          'priority': colorValue
                        };
                        addItem(todoItem);
                        Navigator.pop(context);
                      }),
                ]))));
  }
}
