import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pare/pages/login.dart';
import 'package:pare/pages/signup.dart';
import 'package:pare/utils/constant.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.primaryColor,
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  Image.asset(Constants.img1),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        Constants.strPairUp.toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 22,
                            height: 1.5,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w400),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AutoSizeText(
                      Constants.strLetsGetStarted,
                      minFontSize: 35,
                      maxFontSize: 45,
                      style: TextStyle(
                          letterSpacing: 1.3,
                          // fontSize: 50,
                          fontFamily: Constants.fontFamily,
                          color: Constants.greenColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: CustomButton(
                          title: "START",
                          onClickCallBack: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          }))
                ],
              )),
        ));
  }
}
