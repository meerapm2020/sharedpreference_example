import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewtodoApp extends StatefulWidget {
  const NewtodoApp({super.key});

  @override
  State<NewtodoApp> createState() => _NewtodoAppState();
}

class _NewtodoAppState extends State<NewtodoApp> {
  TextEditingController _controller = TextEditingController();
  Color _selectedColor = Colors.blue;
  List<Color> _colorlist = [
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.green
  ];
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasks = prefs.getStringList('todoItems');
      List<String>? colors = prefs.getStringList('todoColors');
      if(tasks!=null && colors!=null){
         setState(() {
          
      
    });

      }
   
  }

  saveItems(List<String> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items', items);
  }

  void addItem(String item) {
    setState(() {
      _items.add(item);
    });
    saveItems(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo Example")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [Text(_items[index])],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 500,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add Task", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Enter task",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text("Pick a task color:"),
                    SizedBox(height: 25),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = _colorlist[index];
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: _colorlist[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 15);
                        },
                        itemCount: _colorlist.length,
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            addItem(_controller.text);
                            _controller.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Add Task"),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
