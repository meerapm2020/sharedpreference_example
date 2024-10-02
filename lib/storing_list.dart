import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StringListExample extends StatefulWidget {
  @override
  _StringListExampleState createState() => _StringListExampleState();
}

class _StringListExampleState extends State<StringListExample> {
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _items = prefs.getStringList('items') ?? [];
    });
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
      appBar: AppBar(title: Text("SharedPreferences - String List")),
      body: Column(
        children: [
          TextField(
            onSubmitted: (val) {
              addItem(val);
            },
            decoration: InputDecoration(hintText: 'Enter an item'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(_items[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
