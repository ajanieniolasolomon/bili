import 'package:flutter/material.dart';
import '../vmixins/valid_mixins.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'map.dart';
import '../welcome/welcome.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with ValidateMixin  {
  String location ='';



  final  formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

                  "assets/map.flr",
                  animation: "move",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(100.0),

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
                        _buildLocation(),
                        SizedBox(height: 20.0,),
                        _submit(),



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

  Widget _buildLocation(){
    return TextFormField(
      validator: validateEmail,onSaved: (String value){
      location= value;
    },
      keyboardType: TextInputType.text,

      decoration: new InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blueAccent,width: 2.0
              )
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFe5e5e5),width: 2.0),
          ),
          suffixIcon: Icon(Icons.map),
          hintText: "State"
      ),
    );

  }

  Widget _submit(){
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(70.0),
          bottomRight: Radius.circular(70.0)),
      child: MaterialButton(onPressed:(){

        if(formKey.currentState.validate()){
          formKey.currentState.save();
          Route route = MaterialPageRoute(builder: (context) => Map(location));

                                Navigator.pushReplacement(context, route);


//          _scaffoldKey.currentState.showSnackBar(
//              SnackBar(
//                backgroundColor: Colors.redAccent,
//                content: Text('This number is not registered ',style: TextStyle(color:Colors.white),),
//                duration: Duration(seconds: 2),
//              ));


        }


      },
        height: 50.0,
        minWidth: double.infinity,
        color:Colors.redAccent,
        child: Text("Search",style: TextStyle(color: Colors.white,fontSize: 20.0),),
      ),
    );
  }
}


    