import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/image_model.dart';
import 'dart:convert';
import 'dart:async';
import 'widget/image_list.dart';
import 'screen/loginn.dart';
import 'bloc/provider.dart';
import 'screen/lunch.dart';
import 'welcome/welcome.dart';
import 'screen/home.dart';
class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
  final String title;

  App({this.title});
}

class _AppState extends State<App> with TickerProviderStateMixin {




  @override
  Widget build(BuildContext context) {
    return Provider(
      child: Scaffold(


body:Welcome(),

    ),
    );


  }
}
