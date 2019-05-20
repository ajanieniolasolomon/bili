import 'package:flutter/material.dart';
import '../vmixins/valid_mixins.dart';
import '../service/main.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> with ValidateMixin {
  String email = '';
  TextEditingController nameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _animation = "scan";
  final formKey = GlobalKey<FormState>();

  final MainService service = new MainService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(Icons.menu,color: Colors.black26,),
        title: Text("Add Challenge",style: TextStyle(color: Colors.black26),),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.all(18.0),
          child: Form(
            key: formKey,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  emailField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.camera_roll), onPressed: () {}),
                      _buildSubmit(context),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildSubmit(BuildContext context) {
    return RaisedButton(
      color: Colors.redAccent,
      onPressed: () {


        if (formKey.currentState.validate()) {

          formKey.currentState.save();
          service.addPost(email,'0909034535').then((res){
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Post added  😁'),
                  duration: Duration(seconds: 3),
                ));
          }).catchError((err){
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('😡 ${err}'),
                  duration: Duration(seconds: 3),
                ));
          });
          formKey.currentState.reset();
        }
      },
      child: Text(
        "challenge",
        style: TextStyle(color: Colors.white),
      ),
      elevation: 4.0,
    );
  }

  Widget emailField() {
    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Challenge',
        hintText: 'Start a challenge',
        enabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border

            ),
        border: const OutlineInputBorder(),
      ),
      validator: validateEmail,
      onSaved: (v) {
        email = v;
      },
    );
  }
}
