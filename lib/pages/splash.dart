// ignore: todo

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pare/pages/tabbar.dart';
import 'package:pare/pages/welcome.dart';
import 'package:pare/utils/constant.dart';

import '../services/shared_preference.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Timer for the go to welcome screen
    _timer = Timer(const Duration(seconds: 3), () => pushNextScreen());
  }

  @override
  void dispose() {
    super.dispose();

    _timer!.cancel();
  }

  pushNextScreen() async {
    // ignore: unnecessary_null_comparison
    if (await StorageHelper.get(Preferences.isLoggedIn) != null) {
      if (await StorageHelper.get(Preferences.isLoggedIn) == "true") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const TabbarPage()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomePage()),
            (Route<dynamic> route) => false);
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const WelcomePage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Constants.greenColor,
      body: Center(
          child: Image.asset(
        Constants.imgSplash,
        // height: screenHeight,
        fit: BoxFit.fitHeight,
      )),
    );
  }
}
