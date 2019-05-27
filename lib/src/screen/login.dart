import 'package:flutter/material.dart';
import '../vmixins/valid_mixins.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'dart:async';
import '../service/main.dart';
import 'reg.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>  with ValidateMixin{
  String email ='';
  String pwd ='';
bool loading = false ;
  SharedPreferences sharedPreferences;
  String _animation = "scan";
  final  formKey = GlobalKey<FormState>();
  final MainService  service = new MainService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 // final LocalStorage storage = new LocalStorage('bili');

  Future<String>  _code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey ,
      body: Container(

        child:

        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

Text("Please Scan the QRCODE on the pack."),
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
              ),
loading==true?new CircularProgressIndicator():new Container()
            ],
          ),
        )
      ) ,

    );
  }


  void Scann(){

    setState(() {

      loading = true;
      _code= new QRCodeReader()
          .setAutoFocusIntervalInMs(200) // default 5000
          .setForceAutoFocus(true) // default false
          .setTorchEnabled(true) // default false
          .setHandlePermissions(true) // default true
          .setExecuteAfterPermissionGranted(true) // default true
          .scan();


      _code.asStream().listen((res)=>{

check(res)

 });
    });

  }

check(name,[contexts]) async{
  sharedPreferences = await SharedPreferences.getInstance();
  return service.doesNameAlreadyExist(name.toString()).then((res){

    if(res){

      setState(() {
        sharedPreferences.setString("id", name);
        loading = false;
      });
      Route route = MaterialPageRoute(builder: (context) => Reg());

      Navigator.pushReplacement(context, route);

    }else{
      setState(() {
        loading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Erroe in codeId',style: TextStyle(color:Colors.white),),
            duration: Duration(seconds: 5),
          ));
    }


 }).catchError((err){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(err.toString(),style: TextStyle(color:Colors.white),),
          duration: Duration(seconds: 2),
        ));

  });

}

}

