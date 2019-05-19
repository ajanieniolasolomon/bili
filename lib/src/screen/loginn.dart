import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';

class Loginn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
_buildemail(bloc),
          _buildpwd(bloc),
          _submitButton(bloc)
        ],
      ),
    );
  }

  Widget _buildemail(Bloc bloc){
    return StreamBuilder(
      stream: bloc.email ,
      builder: (BuildContext context,AsyncSnapshot snapshot){


    return TextField(
onChanged:  bloc.emailChange,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'you@company.com',
        labelText: 'Email',
          errorText: snapshot.error

      ),
    );
      },
    );


  }Widget _buildpwd(Bloc bloc){

    return StreamBuilder(
      stream: bloc.pwd,
      builder: (BuildContext context, AsyncSnapshot snapshot){
            return TextField(
              onChanged: bloc.pwdChange,
obscureText: true,
      decoration: InputDecoration(
        hintText: '******',
        labelText: 'password',
        errorText: snapshot.error

      ),
    );
      },
    );

  }
  
  Widget _submitButton(Bloc bloc){
    return StreamBuilder(stream: bloc.submitVaild,
    builder: (BuildContext context,AsyncSnapshot snapshot){



     return RaisedButton(onPressed:snapshot.hasData? bloc.submit: null,child: Text("Login"),color: Colors.blue,);
    },
    );

    //return
  }
  
}
