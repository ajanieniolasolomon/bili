import 'package:flutter/material.dart';
import 'data.dart';
import 'indicator.dart';
import 'onboarding.dart';
import 'colors.dart';
import 'package:provider/provider.dart';
import '../welcome/welcome.dart';
import '../welcome/login.dart';
import '../map/search.dart';
import '../screen/reg.dart';
import '../screen/login.dart';

class Onboading extends StatefulWidget {
  @override
  _OnboadingState createState() => _OnboadingState();
}

class _OnboadingState extends State<Onboading> {
  final PageController pageController = PageController();
  int currentPage = 0;
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: pageController,
          onPageChanged: (index){
            currentPage = index;
            if (currentPage == onboardData.length - 1) {
              setState(() {
                lastPage = true;
              });


            } else {
              setState(() {
                lastPage = false;
              });


            }

          },
          //physics: NeverScrollableScrollPhysics(),
          itemCount: onboardData.length,
          itemBuilder: (context, index) {
            return OnboardPage(
              pageController: pageController,
              pageModel: onboardData[index],
            );
          },
        ),


        lastPage== true?Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0, left: 10),
            child: Row(
              children: <Widget>[
                new SizedBox(

                  width: MediaQuery.of(context).size.width*0.4,
                  height: 40.0,
                  child: new RaisedButton(
                      color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text("Login",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      onPressed:(){
                      Route route = MaterialPageRoute(builder: (context) => SignIn());

                      Navigator.push(context, route);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(70.0),
                              bottomRight: Radius.circular(70.0)))
                  ),
                ),
SizedBox(width: 10.0,),
                new SizedBox(

                  width: MediaQuery.of(context).size.width*0.4,
                  height: 40.0,
                  child: new RaisedButton(
                      color: Colors.redAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[


                          Text("Register",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      onPressed:(){
                      Route route = MaterialPageRoute(builder: (context) => Login());

                      Navigator.push(context, route);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(70.0),
                              bottomRight: Radius.circular(70.0)))
                  ),
                ),
              ],
            ),
          ),
        ):Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0, left: 40),
            child: PageViewIndicator(
              controller: pageController,
              itemCount: onboardData.length,
              color: colorProvider.color,
            ),
          ),
        ),
      ],
    );
  }
}
