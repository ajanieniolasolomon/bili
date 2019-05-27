import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'onbording.dart';

class MainLand extends StatefulWidget {
  @override
  _MainLandState createState() => _MainLandState();
}

class _MainLandState extends State<MainLand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ChangeNotifierProvider(
        builder: (context) => ColorProvider(),
        child: Onboading(),
      ),
    );
  }
}
