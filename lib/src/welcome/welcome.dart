import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _pos  =  0;
   Timer _timer;
   List photos = ["assets/TheArchitect.flr","assets/TheRefactorer.flr","assets/Sourcerer.flr","assets/TheJack.flr"];

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Scaffold(
          backgroundColor: const Color.fromRGBO(59, 59, 73, 1),
        body: Container(
          margin: EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 50,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(

                  height: 160,
                  width: 160,
                  child: FlareActor(

                    "assets/TheArchitect.flr",
                    animation: "idle",
color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text("Bili Trend Maker",style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 5,color: Colors.white
                ),),
              ),
              SizedBox(height: 10,),
              Divider(color: Colors.white),
              Text("Team Genre",style: TextStyle(
                  fontSize: 25,color: Colors.white
              )),
              SizedBox(height: 50,),
              new SizedBox(

                width: MediaQuery.of(context).size.width*0.75,
                height: 40.0,
                child: new RaisedButton(
                  color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Login",style: TextStyle(color: Colors.white,fontSize: 15),),
                      Icon(Icons.arrow_forward,color: Colors.white,)
                    ],
                  ),
                  onPressed:(){
                    Route route = MaterialPageRoute(builder: (context) => SignIn());

                    Navigator.push(context, route);
                  },
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(70.0),
                            bottomRight: Radius.circular(70.0)))
                ),
              ),
              SizedBox(height: 30,),
              new SizedBox(

                width: MediaQuery.of(context).size.width*0.75,
                height: 40.0,
                child: new RaisedButton(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Icon(Icons.arrow_back,color: Colors.white,),
                        Text("Register",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    onPressed:(){},
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(70.0),
                            bottomRight: Radius.circular(70.0)))
                ),
              ),
            ],
          ),

        )
      ),
    );
  }
}
