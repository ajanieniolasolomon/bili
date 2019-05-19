import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MainService{
  StreamBuilder _stream;

 login(String code) async{
   try{
     await  Firestore.instance.collection("user").where("barcode",isEqualTo: code).getDocuments();
   }catch(err){
     return false;
   }


  }
Future<dynamic> doesNameAlreadyExist(String name) async {
   final QuerySnapshot result = await Firestore.instance
       .collection('user')
       .where('barcode', isEqualTo: name)
       .limit(1)
       .getDocuments();
   final List<DocumentSnapshot> documents = result.documents;

   return documents.length == 1;
 }


Future<Null>addPost(String status,String tweetId) async

 {

   var data = {
     'status':status,
     'tweetId':tweetId,
     'tweetBy':'',
     'retweetId':'',
     'retweetBy':'',
     'tweetImage':'',
     'likeCount':0,
     'retweetCount':0,
     'postedOn':DateTime.now(),



   };
   final  result = await Firestore.instance.collection('post').add(data);

   try{
     result.get().then((res){

       Firestore.instance.collection('post').document(res.documentID).updateData(
         {
           'tweetId':res.documentID
         }
       );



     }).catchError((err){
       print(err);
     });

   }catch(err){

   }

 }

 Future<Null> AddComment(String id, String status) async {
   var data = {
     'comment': status,
     'postId': id,
     'commentBy': '0908765643',
     'commentOn':  new DateTime.now().toUtc().toIso8601String(),
     'commentId': '',


   };
   final result = await Firestore.instance.collection('comment').add(data);
   try {
     result.get().then((res) {
       Firestore.instance.collection('comment')
           .document(res.documentID)
           .updateData(
           {
             'commentId': res.documentID
           }
       );
     }).catchError((err) {
       print("error");
     });
   } catch (err) {


   }
 }
  Future<Null> likeButton(postID,rate) async {

 final result = await  Firestore.instance.collection('rate').where('postId', isEqualTo:postID).where('commentBy',isEqualTo:'0908765643' ).snapshots();


result.listen((data) async{
if(data.documents.length ==1){

Firestore.instance.collection('rate').document(data.documents[0]['voteId']).updateData({
    "rate":rate
  });

}
else{
  var data = {
    'voteId': '',
    'postId': postID,
    'commentBy': '0908765643',

    'rate': rate,


  };
  final result = await  Firestore.instance.collection('rate').add(data);
  try {
    result.get().then((res) {
      Firestore.instance.collection('rate')
          .document(res.documentID)
          .updateData(
          {
            'voteId': res.documentID
          }
      );
    }).catchError((err) {

    });
  } catch (err) {


  }

}



   }



);



 }



}