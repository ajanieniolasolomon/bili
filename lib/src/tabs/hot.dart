import 'package:flutter/material.dart';


class Hot extends StatefulWidget {
  @override
  _HotState createState() => _HotState();
}

class _HotState extends State<Hot> {
  var selectedDate = 18;
  var selectedBarber = 'Jonathan';
  var selectedTime = '12:30';
  @override
  Widget build(BuildContext context) {
    return ListView(


      children: <Widget>[


        Stack(
          children: <Widget>[
            Container(
              height: 100.0,

            ),
            Positioned(
              top: 0.0,
              left: 15.0,
              right: 15.0,
              child: Container(
                height: 60.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    Chip(
                      backgroundColor: Colors.red,

                      label: Text('Music & Dance',style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 15,),
                    Chip(
                      backgroundColor: Colors.red,

                      label: Text('Fitness & Health',style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 15,),
                    Chip(
                      backgroundColor: Colors.red,

                      label: Text('Fitness & Health',style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 5,),
                  ],
                ),
              ),
            )
          ],
        ),





        Container(
          height: 400,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:List.generate(5,(int i){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(flex:1, child:
                  Row(
                    children: <Widget>[
                      Container(
                        width:200,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/illustration3.png"),
                          ),
                          title: Text("ajax"),

                          subtitle: Text("!!kolo",style: TextStyle(
                              color: Colors.red
                          ),),
                        ),
                      ),
                    ],
                  )),
                  Flexible(flex: 5,

                      child: Container(
                          color: Colors.deepOrangeAccent,
                          margin: EdgeInsets.all( 13.0),

                          child: Image.asset("assets/illustration.png",height: 200,width: MediaQuery.of(context).size.width * 0.6,))),
                  SizedBox(height: 4.0,),

                ],
              );
            }),
          ),
        ),


      ],
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
