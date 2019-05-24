import 'package:flutter/material.dart';

import 'welcome/welcome.dart';
import 'map/map.dart';
class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
  final String title;

  App({this.title});
}

class _AppState extends State<App> with TickerProviderStateMixin {




  @override
  Widget build(BuildContext context) {
    return  Scaffold(


body:Map(),

    );



  }
}
