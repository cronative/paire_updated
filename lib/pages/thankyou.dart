import 'package:flutter/material.dart';
import 'package:pare/main.dart';
import 'package:pare/pages/questions.dart';
import 'package:pare/pages/signup.dart';
import 'package:pare/pages/tabbar.dart';
import 'package:pare/utils/constant.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class ThankYouPage extends StatefulWidget {
  bool? isSellerQuiz;
  int? quizScre;
  ThankYouPage({Key? key, this.isSellerQuiz, this.quizScre}) : super(key: key);
  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  ConfettiController? _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(minutes: 10));
    _controllerCenter!.play();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.primaryColor,
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const TabbarPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ),
        body: SingleChildScrollView(
          child:
              //     ConfettiWidget(
              //   confettiController: _controllerCenter!,
              //   blastDirectionality: BlastDirectionality
              //       .explosive, // don't specify a direction, blast randomly
              //   shouldLoop: true, // start again as soon as the animation is finished
              //   colors: const [
              //     Colors.green,
              //     Colors.blue,
              //     Colors.pink,
              //     Colors.orange,
              //     Colors.purple
              //   ], // manually specify the colors to be used
              //   createParticlePath: drawStar, // define a custom shape/path.
              // )
              // ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ConfettiWidget(
                          confettiController: _controllerCenter!,
                          blastDirection: -pi / 2,
                          emissionFrequency: 0.01,
                          numberOfParticles: 20,
                          maxBlastForce: 100,
                          minBlastForce: 80,
                          gravity: 0.3,
                        ),
                      ),
                      if (!widget.isSellerQuiz!) Image.asset(Constants.img3),
                      if (widget.isSellerQuiz!) Image.asset(Constants.img4),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              Constants.strThankYou,
                              style: TextStyle(
                                  letterSpacing: 1.3,
                                  fontSize: 50,
                                  fontFamily: Constants.fontFamily,
                                  color: Constants.greenColor,
                                  fontWeight: FontWeight.w300),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                !widget.isSellerQuiz!
                                    ? Constants.strTouch.toUpperCase()
                                    : "Completing the quiz".toUpperCase(),
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontSize: 22,
                                    height: 1.5,
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: FontWeight.w400),
                              ))),
                      if (widget.isSellerQuiz!)
                        Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Align(
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'You got ',
                                    style: TextStyle(
                                        color: Constants.greenColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w300),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.quizScre!.toString(),
                                        style: TextStyle(
                                            color: Constants.greenColor,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: ' out of 20',
                                        style: TextStyle(
                                            color: Constants.greenColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      TextSpan(
                                        text: '\n correct answers',
                                        style: TextStyle(
                                            color: Constants.greenColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ]),
                              ),
                              // Text(
                              //   "You got 16 out of 20 correct answers",
                              //   style: TextStyle(
                              //       letterSpacing: 2,
                              //       fontSize: 22,
                              //       height: 1.5,
                              //       fontFamily: Constants.fontFamily,
                              //       fontWeight: FontWeight.w400),
                              // )
                            )),
                      // Padding(
                      //     padding: const EdgeInsets.only(top: 40),
                      //     child: CustomButton(
                      //         title: Constants.strTryAgain.toUpperCase(),
                      //         onClickCallBack: () {
                      //           if (widget.isSellerQuiz!) {
                      //             Navigator.of(context).pushAndRemoveUntil(
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         const TabbarPage()),
                      //                 (Route<dynamic> route) => false);
                      //           } else {
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       const QuestionsPage()),
                      //             );
                      //           }

                      //           // Navigator.push(
                      //           //   context,
                      //           //   MaterialPageRoute(
                      //           //       builder: (context) => const SignUpPage()),
                      //           // );
                      //         })),
                      if (!widget.isSellerQuiz!)
                        Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: CustomButton(
                                title: Constants.strQuiz.toUpperCase(),
                                backColor: Constants.secondaryColor,
                                onClickCallBack: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TabbarPage()),
                                      (Route<dynamic> route) => false);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const SignUpPage()),
                                  // );
                                }))
                    ],
                  )),
        ));
  }
}
