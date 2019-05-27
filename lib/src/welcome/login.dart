import "package:flutter/material.dart";
import 'welcome.dart';
import '../vmixins/valid_mixins.dart';
import 'package:flare_flutter/flare_actor.dart';
import  '../screen/home.dart';
import '../service/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with ValidateMixin {
  String phone_number ='';
bool loading = false;
  SharedPreferences sharedPreferences;
  String _animation = "scan";
  final  formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MainService _services = new MainService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
key:_scaffoldKey ,
      resizeToAvoidBottomPadding: false,
resizeToAvoidBottomInset: false,
//      appBar: AppBar(
//        elevation: 0.0,
//        title: Text("Login"),
//      ),
      body: SafeArea(
        child:  Stack(

          fit:StackFit.expand,
          children: <Widget>[

            FractionallySizedBox(

              heightFactor: .5,
              alignment: Alignment.topCenter,
              child: FlareActor(

                "assets/auth.flr",
                animation: "auth",
              fit: BoxFit.cover,
              ),
            ),
            Container(
                margin: EdgeInsets.all(60.0),

                child: Text("Bili",style: TextStyle(color: Colors.redAccent,fontSize: 45,fontWeight: FontWeight.w900),)),
            FractionallySizedBox(

              heightFactor: .6,
              alignment: Alignment.bottomCenter,
              child:  Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0.0, -0.5),
                      blurRadius: 15.0
                    )
                  ],
                   borderRadius: BorderRadius.only(
                     topRight: Radius.circular(40.0),
                     topLeft: Radius.circular(40.0)
                   ),

                ),
                child: Padding(padding:EdgeInsets.symmetric(
                  horizontal: 22.0,

                ) ,child: Form(
                  key: formKey,
                  child: Column(

                    children: <Widget>[
                      SizedBox(height: 5.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 70.0,
                            height: 70.0,

                            child: IconButton(icon: Icon(Icons.home), onPressed: (){

                              Route route = MaterialPageRoute(builder: (context) => Welcome());

                              Navigator.pushReplacement(context, route);
                            },color: Colors.green,),
                          ),
                          SizedBox(width: 20.0,),
                          Container(
                            width: 70.0,
                            height: 70.0,

                            child: IconButton(icon: Icon(Icons.person), onPressed: (){},color: Colors.red,),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      _buildEmail(),
                      SizedBox(height: 20.0,),
                      _submit(),
                      SizedBox(height: 20.0,),
loading==true?CircularProgressIndicator(backgroundColor: Colors.blue,):Container()


                    ],
                  ),
                )

                  ,),
              ),


            )
           ,
          ],
        ),
      )
    );
  }


    Widget _buildEmail(){
      return TextFormField(
          validator: validateEmail,onSaved: (String value){
        phone_number= value;
      },
          keyboardType: TextInputType.number,

         decoration: new InputDecoration(
           focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(
               color: Colors.blueAccent,width: 2.0
             )
           ),
           enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Color(0xFFe5e5e5),width: 2.0),
           ),
           suffixIcon: Icon(Icons.phone_android),
           hintText: "PhoneNumber"
         ),
      );

    }

    Widget _submit(){


    return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(70.0),
                  bottomRight: Radius.circular(70.0)),
      child: MaterialButton(onPressed:() async{
        setState(() {
          loading = true;
        });
        sharedPreferences = await SharedPreferences.getInstance();
        if(formKey.currentState.validate()){
          formKey.currentState.save();
_services.SignIn(phone_number).then((res){

  if(res){
    setState(() {
      loading = false;
      sharedPreferences.setString("phone_number", phone_number);


    });
    Route route = MaterialPageRoute(builder: (context) =>Home());

    Navigator.push(context, route);
  }else{
    setState(() {
      loading = false;
    });
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('This number is not registered ',style: TextStyle(color:Colors.white),),
          duration: Duration(seconds: 2),
        ));
  }
}).catchError((err){
  setState(() {
    loading = false;
  });
  _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(err),
        duration: Duration(seconds: 2),
      ));
});


        }


      },
      height: 50.0,
        minWidth: double.infinity,
        color:Colors.redAccent,
        child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 20.0),),
      ),
    );
    }

}
