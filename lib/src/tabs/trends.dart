import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screen/comment.dart';
import '../service/main.dart';
import 'dart:math';
class Trends extends StatefulWidget {
  @override
  _TrendsState createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  RegExp exp = new RegExp(r"(^|\s)#(\w+)");
  MainService service;
  var clo = [Colors.redAccent,Colors.green,Colors.blueAccent,Colors.purple,Colors.indigoAccent,Colors.black];
  final _random = new Random();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    service = new MainService();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('post').orderBy(
              'postedOn', descending: true).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              default:
                return new Container(

                    child: new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Container(
                            margin: EdgeInsets.all(12.0),
                            width: 222.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 4.0,
                                      blurRadius: 4.0
                                  )
                                ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 16.0, 8.0, 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[

                                      Row(
                                        children: <Widget>[
                                          new Container(
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new NetworkImage(
                                                      "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                                            ),
                                          ),
                                          new SizedBox(
                                            width: 10.0,
                                          ),
                                          new Text(
                                            "eniola",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      new Text(
                                        exp.stringMatch(document['status']) !=
                                            null ? exp.stringMatch(
                                            document['status']).toString() : "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent),
                                      )
                                    ],
                                  ),
                                ),
                                document['tweetImage'] != "" ?
                                Column(

                                  children: <Widget>[


                                    Hero(
                                      tag: document['tweetId'],
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Comment(document: document,)),
                                          );
                                        },
                                        child: FadeInImage.assetNetwork (
                                            fadeInCurve: Curves.bounceIn,
height: 250.0,
                                            width:MediaQuery.of(context).size.width ,
                                            fit: BoxFit.cover,
                                            placeholder: 'assets/holder.jpg', image:   document['tweetImage'])

                                      ),
                                    ),
                                    Container(
                                      child: Text(document['status']),
                                      margin: EdgeInsets.all(14.0),
                                    )
                                  ],
                                )
                                    :

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          Comment(document: document,)),
                                    );
                                  },
                                  child: Container(
                                    color: clo[_random.nextInt(clo.length)],
                                    height: MediaQuery.of(context).size.height* 0.3,
                                    margin: EdgeInsets.all(14.0),
                                    child:

                                    Center(child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(document['status'],
                                        style: TextStyle(color: Colors.white,
                                            fontSize: 18.0),),
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[

                                          StreamBuilder<QuerySnapshot>(
                                            stream:Firestore.instance.collection('rate').where('rate',isEqualTo: 'upvote').where('postId',isEqualTo:document['tweetId'] ).snapshots(),
                                            builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (snapshot.hasError) return new Text('${snapshot.error}');
            switch(snapshot.connectionState) {

            case ConnectionState.waiting:
                    return new Center(child: new CircularProgressIndicator());
              default:
                return GestureDetector(
                  onTap: () {
                    vote(document['tweetId'], 'upvote');
                  },
                  child: Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(snapshot.data.documents.length.toString()),
                    ),
                    label: new Icon(Icons.arrow_upward),
                  ),
                );

            }

                                            }
                                          ),
                                          new SizedBox(
                                            width: 6.0,
                                          ),

                                          StreamBuilder<QuerySnapshot>(
                                              stream:Firestore.instance.collection('rate').where('rate',isEqualTo: 'downvote').where('postId',isEqualTo:document['tweetId'] ).snapshots(),
                                              builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (snapshot.hasError) return new Text('${snapshot.error}');
                                                switch(snapshot.connectionState) {

                                                  case ConnectionState.waiting:
                                                    return new Center(child: new CircularProgressIndicator());
                                                  default:
                                                    return GestureDetector(
                                                      onTap: () {
                                                        vote(document['tweetId'], 'downvote');
                                                      },
                                                      child: Chip(
                                                        avatar: CircleAvatar(
                                                          backgroundColor: Colors.red,
                                                          child: Text(snapshot.data.documents.length.toString()),
                                                        ),
                                                        label: new Icon(Icons.arrow_downward),
                                                      ),
                                                    );

                                                }

                                              }
                                          ),
                                          new SizedBox(
                                            width: 6.0,
                                          ),


                                        ],
                                      ),

                                    ],
                                  ),
                                ),


                              ],


                            ),
                          );
                        }).toList()
                    )
                );
            };
          },
        )


    );
  }

  Widget post(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) =>
      index == 0
          ? new SizedBox(
        child: Container(),
        //height: deviceSize.height * 0.15,
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                      ),
                    ),
                    new SizedBox(
                      width: 10.0,
                    ),
                    new Text(
                      "imthpk",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                new Text(
                  "!isabihiv",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.redAccent),
                )
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: new Image.network(
              "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Icon(
                        Icons.favorite_border
                    ),
                    new SizedBox(
                      width: 16.0,
                    ),
                    new Icon(
                        Icons.comment
                    ),
                    new SizedBox(
                      width: 16.0,
                    ),
                    new Icon(Icons.book),
                  ],
                ),
                new Icon(Icons.bookmark)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Liked by pawankumar, pk and 528,331 others",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                  ),
                ),
                new SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: new TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add a comment...",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:
            Text("1 Day Ago", style: TextStyle(color: Colors.grey)),
          )
        ],
      ),
    );
  }

  vote(id, state) {
    service.changeSchool(id, state);

  }

}