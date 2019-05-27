import 'package:flutter/material.dart';
import 'screen/home.dart';
import 'welcome/welcome.dart';
import 'land/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
  final String title;

  App({this.title});

}

class _AppState extends State<App> with TickerProviderStateMixin {
  SharedPreferences sharedPreferences;
Object defaults;

Future chech()async{
  sharedPreferences = await SharedPreferences.getInstance();
  setState(() {
    if(sharedPreferences.getString("phone_number") != null){

      defaults = Home();
    }
    else{

      defaults = MainLand();
    }
  });
}

@override void initState() {
  chech();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(


body: defaults,

    );



  }
}
