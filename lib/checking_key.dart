import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckKeyExample extends StatefulWidget {
  @override
  _CheckKeyExampleState createState() => _CheckKeyExampleState();
}

class _CheckKeyExampleState extends State<CheckKeyExample> {
  bool _hasKey = false;

  @override
  void initState() {
    super.initState();
    _checkKey();
  }

  
  _checkKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasKey = prefs.containsKey('exampleKey');
    });
  }

  // Save a value for the key
  _saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('exampleKey', 'Some value');
    _checkKey();
  }

  // Remove the key
  _removeKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('exampleKey');
    _checkKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Check if Key Exists")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_hasKey ? 'Key exists' : 'Key does not exist'),
            ElevatedButton(
              onPressed: _saveValue,
              child: Text('Save Value'),
            ),
            ElevatedButton(
              onPressed: _removeKey,
              child: Text('Remove Key'),
            ),
          ],
        ),
      ),
    );
  }
}
