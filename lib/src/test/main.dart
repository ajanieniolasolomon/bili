import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'onbording.dart';

class MainTest extends StatefulWidget {
  @override
  _MainTestState createState() => _MainTestState();
}

class _MainTestState extends State<MainTest> {
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
