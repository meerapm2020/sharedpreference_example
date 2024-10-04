import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListNew extends StatefulWidget {
  @override
  _TodoListNewState createState() => _TodoListNewState();
}

class _TodoListNewState extends State<TodoListNew> {
  List<Map<String, dynamic>> _todoItems = [];
  Color _selectedColor = Colors.blue;
  List<Color> _colorlist = [
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.green,
    Colors.yellowAccent,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _loadTodoItems();
  }

  // Load items from SharedPreferences
  _loadTodoItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? tasks = prefs.getStringList('todoItems');
      List<String>? colors = prefs.getStringList('todoColors');

      if (tasks != null && colors != null) {
        setState(() {
          _todoItems = List.generate(tasks.length, (index) {
            return {
              'task': tasks[index],
              'color': Color(int.parse(colors[index])),
            };
          });
        });
      }
    } catch (e) {
      print("Error loading todo items: $e");
    }
  }

  _saveTodoItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> tasks =
          _todoItems.map((item) => item['task'] as String).toList();
      List<String> colors = _todoItems.map((item) {
        final Color color = item['color'] as Color;
        return color.value.toString();
      }).toList();

      await prefs.setStringList('todoItems', tasks);
      await prefs.setStringList('todoColors', colors);
    } catch (e) {
      print("Error saving todo items: $e");
    }
  }

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add({'task': task, 'color': _selectedColor});
      });
      _saveTodoItems();
    }
  }

  void _promptAddTodoItem() {
    String newTask = "";
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                autofocus: true,
                onChanged: (val) {
                  newTask = val;
                },
              ),
              SizedBox(height: 20),
              Text('Pick a task color:'),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: _colorlist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = _colorlist[index];
                        });
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: _colorlist[index],
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                child: Text('Add'),
                onPressed: () {
                  if (newTask.isNotEmpty) {
                    _addTodoItem(newTask);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_todoItems[index]['task']),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                _todoItems.removeAt(index);
                _saveTodoItems();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item deleted'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: _todoItems[index]['color'],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(_todoItems[index]['task']),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddTodoItem,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
