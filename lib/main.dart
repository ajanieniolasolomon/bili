import 'package:flutter/material.dart';
import 'package:flutter_course/src/app.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        fontFamily: 'Pro',
brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),
      home:App(title: 'Flutter Demo Home Page'),
    );
  }
}


