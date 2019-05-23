import 'package:flutter/material.dart';
import 'data.dart';
import 'indicator.dart';
import 'onboarding.dart';
import 'colors.dart';
import 'package:provider/provider.dart';
import '../welcome/welcome.dart';

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
              lastPage = true;

            } else {
              lastPage = false;

            }

          },
          physics: NeverScrollableScrollPhysics(),
          itemCount: onboardData.length,
          itemBuilder: (context, index) {
            return OnboardPage(
              pageController: pageController,
              pageModel: onboardData[index],
            );
          },
        ),
        Container(
          width: double.infinity,
          height: 70,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (context) => Welcome());

                                Navigator.pushReplacement(context, route);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Home',
                      style: Theme.of(context).textTheme.title.copyWith(
                        color: colorProvider.color,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

        lastPage== true?Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0, left: 40),
            child: Text("FINAL"),
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
