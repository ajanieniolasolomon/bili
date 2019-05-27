import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screen/home.dart';
class Map extends StatefulWidget {

  final String location;

  Map(this.location);

  @override
  _MapState createState() => _MapState();


}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  final Set<Marker> _markers = {};
  LatLng  _center = const LatLng(6.514498,  3.3686672);


double zoomValue = 5.0;

@override
void initState() {
  Find();
    super.initState();
  }

  Find(){



  Firestore.instance.collection("location")..where('search',isEqualTo: widget.location.toLowerCase()).getDocuments().then((docs){
if(docs.documents.isNotEmpty){
  for(int i = 0;i<docs.documents.length;i++){
    setState(() {

      _markers.add(
          Marker(markerId:MarkerId( docs.documents[i].data['id']), position:LatLng(docs.documents[i].data['lat'],docs.documents[i].data['lon']),
              infoWindow:InfoWindow(title:docs.documents[i].data['name']),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
          )
      );
    });

  }
}

  });


  }


  void _onMapCreated(GoogleMapController controller) {
  _controller.complete(controller);


  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop:(){
        Route route = MaterialPageRoute(builder: (context) =>Home());

        Navigator.push(context, route);
      } ,
      child: Scaffold(
        body:Stack(
          children: <Widget>[
            _gooleMap(),
            _action(),
            _buildContainer(),
            close()
          ],
        )
      ),
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
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,

        ),
        markers: _markers,

      ),
    );
  }

Widget close(){
  return Positioned(
      top: 64.0,
      left: 34.0,
      child: Container(
        width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black)
          ),

          child: IconButton(icon: Icon(Icons.close,color: Colors.black87,size: 32,), onPressed:(){
            Route route = MaterialPageRoute(builder: (context) =>Home());

            Navigator.push(context, route);

          })));
}


  Widget _boxes(doc){
    return GestureDetector(
      onTap: (){
        _gotoLocation(doc["lat"],doc["lon"]);
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
                    child: Image(image: NetworkImage(doc["image"]),fit: BoxFit.fill,),
                   // child: Image.asset('assets/illustration.png',),
                  ),

                ),
                Container(
                  child: Padding(padding: EdgeInsets.all(8.0),child: myDetails(doc),),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget myDetails( name){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding( padding: EdgeInsets.only(left: 8.0),
        child: Container(
          child: Text(name['name'],style: TextStyle(color: Color(0Xff6200ee),fontSize: 17.0,fontWeight: FontWeight.bold

          ),),
        ),

        ),
        SizedBox(height: 5.0,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Container(
                child: Icon(Icons.star,color: Colors.yellow,size: 15.0,),
              ),Container(
                child: Icon(Icons.star,color: Colors.yellow,size: 15.0,),
              ),Container(
                child: Icon(Icons.star,color: Colors.yellow,size: 15.0,),
              ),Container(
                child: Icon(Icons.star_half,color: Colors.yellow,size: 15.0,),
              ),Container(
                child: Icon(Icons.star_half,color: Colors.yellow,size: 15.0,),
              )

            ],
          ),
        ),
        SizedBox(height: 5.0,),
        Container(
          child: Text(name["address"],style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0
          ),),
          
          
        ),
        SizedBox(height: 5.0,),

        Container(
          child: Text(name["phone"],style: TextStyle(
              color: Colors.black87,
              fontSize: 18.0
          ),),


        ),
      ],
    );
  }

  Widget _buildContainer(){
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('location').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              default:
                return ListView(
                  scrollDirection: Axis.horizontal,
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return  Padding(padding: EdgeInsets.all(8.0),
                        child: _boxes (document),);
                    }).toList()
                );

            }


          }
        ),
      ),
    );
  }


  Future<void> _gotoLocation(double lat,double lon) async{
     final GoogleMapController controllers = await _controller.future;
     
     controllers.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lon),zoom: 15,tilt: 50.0,bearing: 45.0,) ));

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