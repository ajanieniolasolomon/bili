import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(6.3013753, 7.4596887);
double zoomValue = 5.0;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Stack(
        children: <Widget>[
          _gooleMap(),
          _action(),
          _buildContainer()
        ],
      )
    );
  }

  Widget _action(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(

        width:100,
        height: 400,
        child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            _zoomOFunction(),
            _zoomMFunction(),

          ],
        ),
      ),
    );
  }
  Widget _gooleMap(){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        markers: {
          newYork,newYork2
        },
      ),
    );
  }

  Widget _boxes(){
    return GestureDetector(
      onTap: (){
        //_gotolocation(lat,lng);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0xB02196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                   // child: Image(image: NetworkImage(""),fit: BoxFit.fill,),
                    child: Image.asset('assets/illustration.png',),
                  ),

                ),
                Container(
                  child: Padding(padding: EdgeInsets.all(8.0),child: myDetails("hello"),),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget myDetails(String name){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding( padding: EdgeInsets.only(left: 8.0),
        child: Container(
          child: Text("Unth",style: TextStyle(color: Color(0Xff6200ee),fontSize: 24.0,fontWeight: FontWeight.bold

          ),),
        ),

        ),
        SizedBox(height: 5.0,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text("2.1",style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                ),),
              ),
              Container(
                child: Icon(Icons.star,color: Colors.yellow,size: 15.0,),
              ),Container(
                child: Icon(Icons.star,color: Colors.yellow,size: 15.0,),
              ),Container(
                child: Icon(Icons.star,color: Colors.yellow,size: 15.0,),
              ),
              Container(
                child: Text("(789)",style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                ),),
              )
            ],
          ),
        ),
        SizedBox(height: 5.0,),
        Container(
          child: Text("address",style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0
          ),),
          
          
        ),
        SizedBox(height: 5.0,),
        Container(
          child: Text("close",style: TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),),
        )
      ],
    );
  }

  Widget _buildContainer(){
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0,),
            Padding(padding: EdgeInsets.all(8.0),
            child: _boxes (),),
            SizedBox(width: 10.0,),
            Padding(padding: EdgeInsets.all(8.0),
              child: _boxes (),),
            SizedBox(width: 10.0,),
            Padding(padding: EdgeInsets.all(8.0),
              child: _boxes (),)
          ],
        ),
      ),
    );
  }


  Future<void> _gotoLOcation(double lat,double lon) async{
     final GoogleMapController controllers = await _controller.future;
     
     controllers.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lon),zoom: 15,tilt: 50.0,bearing: 45.0) ));

  }


  Widget _zoomMFunction(){
    return Container(
      child: IconButton(icon: Icon(Icons.zoom_out,color: Colors.redAccent,size: 54.0,), onPressed:(){
        zoomValue++;
        _minus(zoomValue);
      }),
    );
  }

  Widget _zoomOFunction(){
    return Column(
      children: <Widget>[
        IconButton(icon: Icon(Icons.zoom_in,color: Colors.black87,size: 54.0,), onPressed:(){
          zoomValue--;
          _minus(zoomValue);
        }),
      ],
    );
  }
 Future<void> _minus(zoomValue) async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(6.3013753, 7.4596887),zoom: zoomValue)));

  }
}


Marker   newYork  = Marker(markerId:MarkerId("ny"),position:LatLng(6.3013753, 7.4596887),
infoWindow:InfoWindow(title: "University of Nigeria Teaching Hospital Enugu"),
icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
);
Marker   newYork2  = Marker(markerId:MarkerId("ny2"),position:LatLng(6.4447253, 7.4800013),
infoWindow:InfoWindow(title: "Enugu State Agency for the Control of HIV/Aids"),
icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
);