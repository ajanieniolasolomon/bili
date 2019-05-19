import 'package:flutter/material.dart';
import '../tabs/trends.dart';
import '../tabs/hot.dart';


class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
 bool active = true;
  var selectedDate = 18;
  var selectedBarber = 'Jonathan';
  var selectedTime = '12:30';
  @override
  Widget build(BuildContext context) {
  return  MaterialApp(

   home: DefaultTabController(
     length: 3,
     child: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: Icon(Icons.menu,color: Colors.grey,),
          title: Text("Bili",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w900,),),
          centerTitle: true,
          actions: <Widget>[IconButton(icon: Icon(Icons.search,color: Colors.grey,), onPressed: (){})],
          bottom: TabBar(
            indicator: UnderlineTabIndicator(

              borderSide: BorderSide(
                color: Colors.red,
                width: 4.0
              ),
              insets: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0)
            ),
 labelColor: Colors.red,
       indicatorColor: Colors.red,
       unselectedLabelColor: Colors.black26,
            indicatorWeight: 15,
            labelStyle: TextStyle(
              fontSize: 12,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w900,

            ),
            tabs: [
              Tab(child: Text("ALL"),),
              Tab(child: Text("TRENDING",)),
              Tab(child: Text("FRESH",))
            ],
          ),
        ),
        body: TabBarView(
          children: [

            Trends(),
            Hot(),
            Hot(),
          ],
        ),
      ),
   ),
  );

  }

  Color switchTimeColor(time) {
    if (time == selectedTime) {
      return Colors.black.withOpacity(0.8);
    } else {
      return Colors.grey.withOpacity(0.2);
    }
  }

  Color switchTimeContentColor(time) {
    if (time == selectedTime) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  selectTime(time) {
    setState(() {
      selectedTime = time;
    });
  }

  Widget getTime(time) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: switchTimeColor(time)),
      height: 50.0,
      width: 75.0,
      child: InkWell(
        onTap: () {
          selectTime(time);
        },
        child: Center(
          child: Text(
            time,
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: switchTimeContentColor(time)),
          ),
        ),
      ),
    );
  }

  Widget getBarber(String imgPath, String name) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  image: DecorationImage(
                      image: AssetImage(imgPath), fit: BoxFit.cover) ),
            ),

          ],
        ),
        SizedBox(height: 7.0),
        Text(
          name,
          style: TextStyle( fontSize: 15.0),
        )
      ],
    );
  }


  Widget getCate(String imgPath, String name) {

    return Container(
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(12.0),
  gradient: LinearGradient(colors:[
Colors.green,
    Colors.deepOrangeAccent
  ],begin: Alignment.centerLeft,

 end: new  Alignment(1.0,1.0)

  )
),
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                image: DecorationImage(image:AssetImage(imgPath), fit: BoxFit.fill )
              ),
            ),
          )
        ],
      ),
    );

  }
  selectBarber(name) {
    setState(() {
      selectedBarber = name;
    });
  }

  Color getSelectedBarber(name) {
    print(selectedBarber);
    print(selectedDate);
    print(selectedTime);
    if (name == selectedBarber) {
      return Colors.green.withOpacity(0.3);
    } else {
      return Colors.transparent;
    }
  }

  Widget getService(String name, int price) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
                fontSize: 17.0, color: Colors.black,fontWeight: FontWeight.bold),
          ),


        ],
      ),
    );
  }

  Widget getDate(int date, String day) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: switchColor(date)),
      width: 60.0,
      height: 60.0,
      child: InkWell(
        onTap: () {
          selectDate(date);
        },
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 7.0),
              Text(
                date.toString(),
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: switchContentColor(date)),
              ),
              Text(
                day,
                style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 15.0,
                    color: switchContentColor(date)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color switchColor(date) {
    if (date == selectedDate) {
      return Colors.black.withOpacity(0.8);
    } else {
      return Colors.grey.withOpacity(0.2);
    }
  }

  Color switchContentColor(date) {
    if (date == selectedDate) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  selectDate(date) {
    setState(() {
      selectedDate = date;
    });
  }
  }




