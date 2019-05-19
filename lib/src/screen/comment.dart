import 'package:flutter/material.dart';
import '../vmixins/valid_mixins.dart';
import 'dart:core';
import '../service/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment extends StatefulWidget {
  final document;

  Comment({this.document});


  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment>
    with SingleTickerProviderStateMixin, ValidateMixin {
  AnimationController _controller;

  Animation gradientPosition;
  String comment = '';
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final MainService service = new MainService();

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Comment"),
//        backgroundColor: Colors.redAccent,
//      ),
//        body: Container(
//          child: AnimatedBuilder(
//      animation: _container,
//      builder: (BuildContext context, Widget widget) {
//          return getView();
//      },
//    ),
//        ));

    return Scaffold(
        resizeToAvoidBottomPadding:false,
        body: CustomScrollView(
        slivers: <Widget>[
        SliverAppBar(

        backgroundColor: Colors.redAccent,
        title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

        IconButton(icon: Icon(Icons.person,color: Colors.white, size: 32.5,),onPressed: (){
    print("hello");
    },)
    ],
    ),
    pinned: true,
    expandedHeight: MediaQuery.of(context).size.height * 0.4,
    flexibleSpace: FlexibleSpaceBar(
    background: Container(
    child: Container(
    color: Colors.white,
    child: Column(

    children: <Widget>[

    Container(

    height: MediaQuery.of(context).size.height * 0.4,
    child: Stack(
    children: <Widget>[
    Container(


    child: Stack(
    children: <Widget>[


    Hero(
    tag: widget.document['tweetId'],
    child:widget.document['tweetImage'] != ""? Image.network(
    widget.document['tweetImage'],
    height: MediaQuery.of(context).size.height * 0.4,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,
    colorBlendMode: BlendMode.hue,
    color: Colors.transparent,

    ):Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(gradientPosition.value, 0),
              end: Alignment(-1, 0),
              colors: [Colors.black12, Colors.black26, Colors.black12]
          )
      ),


    child: Center(child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(widget.document['status'],style: TextStyle(color: Colors.black26,fontSize: 29.0
      ),),
    )),
    ),
    ),


    ],
    ),
    )
    ],
    ),
    ),


    ],

    ),
    )
    ),
    ),
    )
    ,
    SliverList(
    delegate: SliverChildListDelegate([

    Container(
    padding: EdgeInsets.only(left: 15.0),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0)),
    ),
    child: SingleChildScrollView(
    child: Column(
    children:<Widget>[
    Padding(
    padding: const EdgeInsets.all(18.0),
    child: Text(
      widget.document['tweetImage']==""? " ": widget.document['status'],
    style: TextStyle(color: Colors.black),
    ),
    ),
    Form(
    key: formKey,
    child: Align(
    alignment: Alignment.center,
    child: Column(
    children: <Widget>[
    SizedBox(height: 14.0,),
    Padding(
    padding: const EdgeInsets.only(left:8.0,right: 8.0),
    child: _commentField(),
    ),
    Row(
    mainAxisAlignment:
    MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Padding(
    padding: EdgeInsets.all(5.0),
    child: _buildSubmit(context)),
    ],
    )
    ],
    ),
    ),
    ),
    Row(children: <Widget>[
    Text("Comment"),
    Expanded(child: Divider(color:Colors.black))
    ],),
    Container(
      padding: EdgeInsets.only(top: 12.0),
alignment: Alignment.topLeft, child: StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('comment').where('postId',isEqualTo:widget.document['tweetId'] ).snapshots(),
    builder: (BuildContext context,
    AsyncSnapshot<QuerySnapshot> snapshot) {

    if (snapshot.hasError) {

     return Text('unable to fetch data');
    }
    else{

      switch (snapshot.connectionState) {


        case ConnectionState.waiting:

          return new Center(child: new CircularProgressIndicator());


        default:
          return new Column(
              children: snapshot.data.documents
                  .map((DocumentSnapshot document) {
                print(document.data);
                //  print(DateTime(document.data['commentOn']).toString().split("T")[0]);
                return     ListTile(
                  title: Text(document.data['commentOn'].toString().split("T")[0]),
                  subtitle:  Text(document.data['comment'].toString()),
                );
              }).toList()
          );

      }

    }

    },
    )


    )
    ]
    )

    )
    ) ] )

    )]));
    }



  Widget _commentField() {
    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Respond to comment',
        hintText: 'Start a challenge',
        enabledBorder: const OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border

        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0)),
        ),
      ),
      validator: validateEmail,
      onSaved: (v) {
        comment = v;
      },
    );
  }

  Widget _buildSubmit(BuildContext context) {
    return RaisedButton(
      color: Colors.redAccent,
      shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(70.0),
              bottomRight: Radius.circular(70.0))),

      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          service.AddComment(widget.document['tweetId'], comment).
          then((res) {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Comment added😡'),
              duration: Duration(seconds: 3),
            ));
          }).catchError((res) {
//            _scaffoldKey.currentState.showSnackBar(SnackBar(
//              backgroundColor: Colors.redAccent,
//              content: Text('Unable to add comment😡',style: TextStyle(color: Colors.white),),
//              duration: Duration(seconds: 3),
//            ));

          });

          formKey.currentState.reset();
        }
      },
      child: Text(
        "comment",
        style: TextStyle(color: Colors.white),
      ),
      elevation: 4.0,
    );
  }
}
