import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class NumberincrementExample extends StatefulWidget {
  const NumberincrementExample({super.key});
  @override
  State<NumberincrementExample> createState() => _NumberincrementExampleState();
}

class _NumberincrementExampleState extends State<NumberincrementExample> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    loadCounter();
  }

  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
    });
    prefs.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Numberincrement Example")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('counter value:$_counter'),
              ElevatedButton(
                onPressed: incrementCounter,
                child: Text("Increment counter"),
              ),
            ]),
      ),
    );
  }
}
