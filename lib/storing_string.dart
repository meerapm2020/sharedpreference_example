import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesString extends StatefulWidget {
  @override
  _SharedPreferencesStringState createState() =>
      _SharedPreferencesStringState();
}

class _SharedPreferencesStringState extends State<SharedPreferencesString> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    loadName();
  }

  loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'No name saved';
    });
  }

  saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    loadName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SharedPreferences Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Saved name: $_name'),
            TextField(
              onSubmitted: (val) {
                saveName(val);
              },
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
