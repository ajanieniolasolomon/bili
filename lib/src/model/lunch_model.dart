import 'package:flutter/material.dart';


class PageModel {
  var imageUrl;
  var title;
  var body;
  List<Color> titleGradient = [];
  PageModel({this.imageUrl, this.title, this.body, this.titleGradient});
}

 List<List<Color>> gradients = [
   [Color(0xFF9708CC),Color(0xFF43CBFF)],
   [Color(0xFF2859F),Color(0xFFFCCF31)],
   [Color(0xFF5EFCE8),Color(0xFF736EFE)],

 ];


var pageList = [
  PageModel(
      imageUrl: "assets/illustration.png",
      title: "HIV Test",
      body: "Get your HIV saliva test kit.",
      titleGradient: gradients[0]),
  PageModel(
      imageUrl: "assets/illustration2.png",
      title: "TRENDS",
      body: "Startup a trend challenge",
      titleGradient: gradients[1]),
  PageModel(
      imageUrl: "assets/illustration3.png",
      title: "FIND ",
      body: "find new  friends",
      titleGradient: gradients[2]),
];
