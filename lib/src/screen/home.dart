import 'package:flutter/material.dart';
import '../bottomnav/main.dart';
import '../bottomnav/profile.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import '../screen/addp.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  final _pageoptions=[

    Main(),
   AddPost(),
Profile()

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: Scaffold(

        bottomNavigationBar: BottomNavigationBar(
            currentIndex:_page,
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },

            fixedColor: Colors.redAccent,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home),title: Text("Home")),
              BottomNavigationBarItem(icon:Icon(Icons.bookmark),title: Text("Post")),
              BottomNavigationBarItem(icon:Icon(Icons.search),title: Text("Search")),

            ]),
//          bottomNavigationBar: FancyBottomNavigation(
//            circleColor: Colors.red,
//
//              inactiveIconColor: Colors.red,
//              activeIconColor: Colors.white,
//              tabs: [
//              TabData(iconData: Icons.home, title: "Home"),
//              TabData(iconData: Icons.search, title: "Search"),
//              TabData(iconData: Icons.shopping_cart, title: "Basket")
//            ],
//            onTabChangedListener: (position) {
//              setState(() {
//                _page  = position;
//              });
//            },
//          ),
        body:



           _pageoptions[_page]

,

//        floatingActionButton: FloatingActionButton(elevation:12.0,onPressed: (){
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => AddPost()),
//          );
//        },child: Icon(Icons.add_comment,size: 45.0,color: Colors.white,),backgroundColor: Colors.red,),
//        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked

      ),
    );



  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
