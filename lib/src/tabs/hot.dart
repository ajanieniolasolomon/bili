import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../screen/comment.dart';
class Hot extends StatefulWidget {
  @override
  _HotState createState() => _HotState();
}
var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HotState extends State<Hot> {
  var selectedItem = 'All products';
 var clo = [Colors.redAccent,Colors.green,Colors.blueAccent,Colors.purple,Colors.indigoAccent,Colors.yellowAccent];
  final _random = new Random();
  @override
  Widget build(BuildContext context) {
    return Container(

                child: StreamBuilder<QuerySnapshot>(

                  stream: Firestore.instance.collection('temp').orderBy(
                      'vote', descending: true).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) return new Text('${snapshot.error}');
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
      default:
              return Container(

                      child: ListView(

                        scrollDirection: Axis.vertical,
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document){
                            return  Padding(padding: EdgeInsets.all(1.0),

                               child: Column(

                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: <Widget>[
                                   Padding(
                                     padding: const EdgeInsets.only(left:24.0),
                                     child: Align(child: Text(document['status'],style:TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 24.0),),alignment: Alignment.topLeft,),
                                   ),
                                   Padding(
                                     padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
                                     child: Container(
                                       height: MediaQuery.of(context).size.height - 300.0,
                                       child: StreamBuilder<QuerySnapshot>(
                                         stream:Firestore.instance.collection('post').where('tag',isEqualTo:document['status'].toString()).snapshots(),
                                         builder: (BuildContext context,
                                         AsyncSnapshot<QuerySnapshot> snapshot) {
                                           if(snapshot.data == null) return CircularProgressIndicator();

                                           return ListView(
                                             scrollDirection: Axis.horizontal,

                                             children:snapshot.data.documents.map((( documents){

                                               if (snapshot.hasError ) return new Text('${snapshot.error}');


                                               switch (snapshot.connectionState) {
      case ConnectionState.waiting :
                return new Center(child: new CircularProgressIndicator());
      default:


                return Hero(
                  tag: documents['tweetId'],
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            Comment(document: documents,)),
                      );
                    },
                    child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                        width: 225.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  spreadRadius: 4.0,
                                  blurRadius: 4.0
                              )
                            ]
                        ),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 200.0,
                                  width: 225.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                                      image: DecorationImage(
                                          image: NetworkImage(documents['tweetImage']),
                                          fit: BoxFit.cover
                                          ,

                                      ),color: clo[_random.nextInt(clo.length)]
                                  ),
                                ),
                                SizedBox(height: 45.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(documents['status'],
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0
                                    ),
                                  ),
                                ),
                               // SizedBox(height: 5.0),
//                            Padding(
//                              padding: EdgeInsets.only(left: 10.0),
//                              child: Text(document.data['postedOn'],
//                                style: TextStyle(
//                                    fontFamily: 'Raleway',
//                                    fontSize: 14.0,
//                                    color: Colors.grey
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 15.0),
                                Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Container(
                                      height: 0.4,
                                      color: Colors.grey.withOpacity(0.4),
                                    )
                                ),


                              ],
                            )
                          ],
                        )
                    ),
                    ),
                  ),
                );

    }

                                             })
                                           ).toList());
                                         }
                                       ),
                                     ),
                                   ),


                                 ],
                               ),
                            );
                          }
                      ).toList(),
                    ),




              );}


                  }
                ),



        );
  }




  selectedProduct(prodName) {
    setState(() {
      selectedItem = prodName;
    });
  }

  switchHighlight(prodName) {
    if (prodName == selectedItem) {
      return Color(0xFF116D51);
    } else {
      return Colors.grey.withOpacity(0.3);
    }
  }

  switchHighlightColor(prodName) {
    if (prodName == selectedItem) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  switchShadow(prodName) {
    if (prodName == selectedItem) {
      return Color(0xFF116D51).withOpacity(0.4);
    } else {
      return Colors.transparent;
    }
  }
}