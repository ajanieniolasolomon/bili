import "package:flutter/material.dart";

import '../vmixins/valid_mixins.dart';
import 'package:flare_flutter/flare_actor.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with ValidateMixin {
  String email ='';
  String pwd ='';
  String _animation = "scan";
  final  formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        elevation: 0.0,
//        title: Text("Login"),
//      ),
      body: SafeArea(
        child: Stack(

          fit:StackFit.expand,
          children: <Widget>[

            FractionallySizedBox(

              heightFactor: .5,
              alignment: Alignment.topCenter,
              child: FlareActor(

                "assets/TheJack.flr",
                animation: "idle",
              fit: BoxFit.cover,
              ),
            ),
            Container(
                margin: EdgeInsets.all(90.0),

                child: Text("Bili",style: TextStyle(color: Colors.red,fontSize: 45,fontWeight: FontWeight.w900),)),
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

                ) ,child:Column(

                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 70.0,
                          height: 70.0,

                          child: IconButton(icon: Icon(Icons.home), onPressed: (){},color: Colors.green,),
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



                  ],
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
        email= value;
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
      child: MaterialButton(onPressed:(){},
      height: 50.0,
        minWidth: double.infinity,
        color:Colors.redAccent,
        child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 20.0),),
      ),
    );
    }

}
