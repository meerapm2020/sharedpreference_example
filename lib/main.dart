import 'package:flutter/material.dart';
import 'package:shared_preferences_examples/checking_key.dart';
import 'package:shared_preferences_examples/newtodo.dart';
import 'package:shared_preferences_examples/storing_int.dart';
import 'package:shared_preferences_examples/storing_list.dart';

import 'package:shared_preferences_examples/storing_string.dart';
import 'package:shared_preferences_examples/todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}
