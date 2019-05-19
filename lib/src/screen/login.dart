import 'package:flutter/material.dart';
import '../vmixins/valid_mixins.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'dart:async';
import '../service/main.dart';
import 'reg.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>  with ValidateMixin{
  String email ='';
  String pwd ='';
  String _animation = "scan";
  final  formKey = GlobalKey<FormState>();
  final MainService  service = new MainService();

  Future<String>  _code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        child:

        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              FutureBuilder<String>(
                future:  _code,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
               return   RaisedButton(onPressed: (){

                 check("dd",context);

               },child: Text("Verify"),);


                },
              ),
              Expanded(child: FlareActor("assets/ghost.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"move",isPaused: false,)),
              Flexible(
               child:  InkWell(
                  onTap: () =>Scann(),
                  child: new Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 50.0,
                    decoration: new BoxDecoration(
                      color: Colors.redAccent,
                      border: new Border.all(color: Colors.white, width: 2.0),
                      borderRadius: new BorderRadius.only(bottomRight:Radius.circular(25.0),topLeft: Radius.circular(20.0)),
                    ),
                    child: new Center(child: new Text('Scan ', style: new TextStyle(fontSize: 22.0, color: Colors.white),),),
                  ),
                ),
              )
            ],
          ),
        )
      ) ,

    );
  }
  Widget _buildEmail(){
  return TextFormField(
validator: validateEmail,onSaved: (String value){
   email= value;
  },
    keyboardType: TextInputType.emailAddress,

    decoration: InputDecoration(
      labelText: 'Email',
      hintText: 'you@company.com'



    )
  );

  }

  void Scann(){

    setState(() {
      _code= new QRCodeReader()
          .setAutoFocusIntervalInMs(200) // default 5000
          .setForceAutoFocus(true) // default false
          .setTorchEnabled(true) // default false
          .setHandlePermissions(true) // default true
          .setExecuteAfterPermissionGranted(true) // default true
          .scan();


      _code.asStream().listen((res)=>{
        print(res)
      });
    });

  }

check(name,[contexts]){
  print("re");
  return service.doesNameAlreadyExist("0djDBjmj6lrYyQWMElrZ").then((res){

    if(res){
      Route route = MaterialPageRoute(builder: (context) => Reg());

      Navigator.pushReplacement(context, route);

    }


 });

}


  Widget _buildPwd(){
    return TextFormField(
        validator: validatePwd
        ,onSaved: (String value){
          pwd = value;
    },
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Password',
            hintText: '*******'


 
        )
    );

  }
  Widget  _buildSubmit(){



    return RaisedButton(color: Colors.blue,onPressed:(){
if(formKey.currentState.validate()){
  formKey.currentState.save();
}

    },child: Text("login"),elevation: 4.0,);

  }
}

