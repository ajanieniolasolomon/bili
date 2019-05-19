import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/image_model.dart';
import 'dart:convert';
import 'dart:async';
import 'widget/image_list.dart';
import 'screen/loginn.dart';
import 'bloc/provider.dart';
import 'screen/lunch.dart';

import 'screen/home.dart';
class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
  final String title;

  App({this.title});
}

class _AppState extends State<App> with TickerProviderStateMixin {
  int counter = 0;
 // ImageModel imageModel;
  List<ImageModel> imageList =[];

  fetchImage() async{
    counter++;
    try{
      http.Response response= await http.get("https://jsonplaceholder.typicode.com/photos/$counter");
      ImageModel imageModels = ImageModel.fromJson(json.decode(response.body));
      setState(() {
        imageList.add(imageModels);

      });

    }catch(err){
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Rewind and remember'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(err.toString()),

                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Regret'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }





  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: Scaffold(


body:Home(),

    ),
    );


  }
}
