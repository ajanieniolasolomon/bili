import 'dart:io';

import 'package:flutter/material.dart';
import '../vmixins/valid_mixins.dart';
import '../service/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> with ValidateMixin {
  String email = '';
  TextEditingController nameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File sampleImage;
 String cloudImage ="";
bool show = false;
  Future getImage(value) async{
    show= true;
    setState(() {
      show= true;
    });
    var now = new DateTime.now().millisecondsSinceEpoch;
    var tempImage = await ImagePicker.pickImage(source:  value == "camera"?ImageSource.camera:ImageSource.gallery);
var date = new DateTime.now().millisecondsSinceEpoch;
  final StorageReference  firebaseStorageRef = FirebaseStorage.instance.ref().child(date.toString());
  final StorageUploadTask task = await firebaseStorageRef.putFile(tempImage);


  try{
    var dowUrl = await(await task.onComplete).ref.getDownloadURL();
    setState(() {
      sampleImage = tempImage;
      show= false;
      cloudImage =  dowUrl;
    });

  }catch(err){
    setState(() {
      show= false;
    });
    show= false;
    print(err);

  }


  }
  Future getVideo() async{
//    var tempImage = await ImagePicker.pickVideo(source: ImageSource.gallery);
//    setState(() {
//      sampleImage = tempImage;
//    });
  }
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
                          icon: Icon(Icons.camera_roll), onPressed: () {
                        _settingModalBottomSheet(context);

                      }),
                      _buildSubmit(context),
                    ],
                  ),
                  show?Center(
                    child: CircularProgressIndicator(),
                  ):Image.network(cloudImage.toString(),height: MediaQuery.of(context).size.height * 0.3,width: MediaQuery.of(context).size.width ,)
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
   var img=cloudImage==" " ?"":cloudImage;
          service.addPost(email,'0909034535',img).then((res){
            setState(() {
              cloudImage ="";
            });

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
  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera,color: Colors.redAccent),
                    title: new Text('Camera'),
                    onTap: () => getImage("camera")
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library,color: Colors.redAccent,),
                  title: new Text('Gallery'),
                  onTap: () =>  getImage("library"),
                ),
                new ListTile(
                  leading: new Icon(Icons.video_library,color: Colors.redAccent),
                  title: new Text('Video'),
                  onTap: () => getVideo(),
                ),
              ],
            ),
          );
        }
    );
  }

}
