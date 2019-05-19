import 'package:flutter/material.dart';

import '../model/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildImage(images[index])  ;
      },
    );
  }

  Widget _buildImage(ImageModel image){
   return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent,width:4.0,)
      ),
      margin: EdgeInsets.all(18.0),
      padding: EdgeInsets.all(18.0),
      child: Column(
        children: <Widget>[
          Image.network(image.url),
          Padding(child: Text(image.title),padding: EdgeInsets.only(top: 7.0),)
        ],
      ),
    );
  }
}
