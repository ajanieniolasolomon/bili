import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<dynamic> SignIn(String num) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('user')
        .where('phone_number', isEqualTo: num)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;

    return documents.length == 1;
  }


Future<Null>addPost(String status,String tweetId,String img) async

 {
   RegExp exp = new RegExp(r"(^|\s)#(\w+)");

   var data = {
     'status':status,
     'tweetId':tweetId,
     'tweetBy':'',
     'retweetId':'',
     'retweetBy':'',
     'tweetImage':img,
     'likeCount':0,
     'retweetCount':0,
     'postedOn':DateTime.now(),
     'tag':   exp.stringMatch(status).toString()



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


  vote(postID,rate) async{


    final result = await  Firestore.instance.collection('rate').where('postId', isEqualTo:postID).where('commentBy',isEqualTo:'0908765643' ).snapshots();
try{

  result.forEach((t){

   if(t.documents.length==0){
     print('empty');
   }else{
     print(t.documents[0]['rate']);
     //update(t.documents[0]['voteId'],rate);
   }




  });

}catch(err){
  print( err);
}

  }

  update(id,status) async {

   await Firestore.instance.collection('rate')
        .document(id)
        .updateData(
        {
          'rate': status
        }
    );
  }


  Future<void> changeSchool(postID,rates) async {

    var data = {
      'voteId': '',
      'postId': postID,
      'commentBy': '0908765643',
      'rate': rates,


    };
    CollectionReference schoolCollection =
    Firestore.instance.collection('rate');

    CollectionReference studentCollection =
    Firestore.instance.collection('rate');
    CollectionReference rate =
    Firestore.instance.collection('rate');

    QuerySnapshot schoolQuery = await rate
        .where('postId', isEqualTo:postID)
        .where('commentBy',isEqualTo:'0908765643' )
        .getDocuments();






print(schoolQuery.documents.length);

if(schoolQuery.documents.length==0){
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
else{
  final DocumentReference studentRef =
  studentCollection.document(schoolQuery.documents[0].documentID);
  Firestore.instance.runTransaction((transaction) async {
    await transaction.update(studentRef,{
      "rate":rates
    });
  });
}



  }




  Future<Uri> _pickSaveImage(String imageId) async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    StorageReference ref =
    FirebaseStorage.instance.ref().child(imageId).child("image.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    return uploadTask.onComplete.then((res){
      res.uploadSessionUri.data;
    });
  }



}