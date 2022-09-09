// ignore: todo

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pare/pages/button_type.dart';
import 'package:pare/pages/cardimage.dart';
import 'package:pare/pages/input_type.dart';
import 'package:pare/pages/radio_type.dart';
import 'package:pare/pages/round_button.dart';
import 'package:pare/pages/thankyou.dart';
import 'package:pare/pages/welcome.dart';
import 'package:pare/utils/constant.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../services/api_service.dart';

class Questions1Page extends StatefulWidget {
  const Questions1Page({Key? key}) : super(key: key);
  @override
  State<Questions1Page> createState() => _Questions1PageState();
}

class _Questions1PageState extends State<Questions1Page> {
  int selectedIndex = 0;
  bool isAnswerGiven = false;
  bool isRightAnswer = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  updateTime() {
    timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        if (selectedIndex != questions1.length - 1) {
          selectedIndex = selectedIndex + 1;
          isAnswerGiven = false;
          isRightAnswer = false;
        } else {
          print(questions1);
          int rightAns = 0;
          for (var q in questions1) {
            if (q["value"] == q["right_ans"]) {
              rightAns = rightAns + 1;
            }
          }
          sendDataToServer(rightAns);
          print(rightAns.toString());
        }
      });

      /// Navigate to seconds screen when timer callback in executed
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const NextScreen(),
      //   ),
      // );
    });
  }

  sendDataToServer(int q_score) {
    print("getIntroFromServer");
    Map<String, String> p = {"score": q_score.toString()};
    setState(() {
      // isDataLoading = true;
    });

    callAPI(context, ApiConstant.quizScrore, ApiConstant.postMethod, p, true)
        .then((response) {
      print(response);
      setState(() {});

      if (response != null) {
        if (response["status"] == 1) {
          for (var i = 0; i < questions1.length; i++) {
            questions1[i]["value"] = "";
          }

          showSnackBar(
              context, response["message"], "", SnackBarType.Sueecss, () {});
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ThankYouPage(isSellerQuiz: true, quizScre: q_score)),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ThankYouPage(
          //             isSellerQuiz: false,
          //           )),
          // );
        } else {
          showSnackBar(
              context, response["message"], "", SnackBarType.Error, () {});
          List errors = response["errors"];
          if (errors.isNotEmpty) {
            // showFlusBar(context, "Errors!", errors[0]["133"]);
          }
        }
      }
    }).onError((error, stackTrace) {
      print("ERRRR");
      print(error);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.greenColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          Constants.imgLogo,
          color: Colors.white,
          width: 120,
        ),
      ),
      /*    bottomNavigationBar: SizedBox(
          height: 80,
          child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 30),
                  child: bottomNextButton(Constants.greenColor, () {
                    setState(() {
                      if (selectedIndex != questions1.length - 1) {
                        selectedIndex = selectedIndex + 1;
                      } else {
                        print(questions1);
                        int rightAns = 0;
                        for (var q in questions1) {
                          if (q["value"] == q["right_ans"]) {
                            rightAns = rightAns + 1;
                          }
                        }
                        sendDataToServer(rightAns);
                        print(rightAns.toString());
                      }
                    });
                  })))), */
      body: SingleChildScrollView(
          child: Column(
        children: [
          questionView(),
          answerView(),
          answertText()
          // Padding(
          //     padding: const EdgeInsets.only(right: 30),
          //     child: bottomNextButton(Constants.greenColor, () {
          //       setState(() {
          //         if (selectedIndex != questions.length - 1) {
          //           selectedIndex = selectedIndex + 1;
          //         }
          //       });
          //     }))
        ],
      )),
    );
  }

  Widget answertText() {
    return isAnswerGiven
        ? ShowUpAnimation(
            delayStart: const Duration(milliseconds: 10),
            animationDuration: const Duration(seconds: 1),
            curve: Curves.bounceIn,
            direction: Direction.vertical,
            offset: 0.5,
            child: Text(
              isAnswerGiven
                  ? isRightAnswer
                      ? "Your answer is right"
                      : "Your answer is wrong"
                  : "",
              style: TextStyle(
                  fontSize: 20,
                  color: isRightAnswer ? Constants.greenColor : Colors.red),
            ),
          )
        : Container();
  }

  Widget answerView() {
    var q = questions1[selectedIndex];
    var screenHeight = MediaQuery.of(context).size.height;
    var qo = q["options"];
    var selecteText = q["value"];
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
        // height: screenHeight * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
                children: List.generate(
                    qo.length,
                    (index) => Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            // widget.onClickCallBack!();
                            if (!isAnswerGiven) {
                              setState(() {
                                isAnswerGiven = true;
                                selecteText = qo[index];
                                q["value"] = selecteText;
                                isRightAnswer =
                                    q["value"] == q["right_ans"] ? true : false;
                              });
                              updateTime();
                            }
                          },
                          child:
                              //  Container(
                              //   margin:
                              //       const EdgeInsets.symmetric(horizontal: 20),
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 10),
                              //   height: 60,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(30),
                              //       border:
                              //           Border.all(color: Constants.greenColor),
                              //       color: qo[index] == selecteText
                              //           ? Constants.greenColor
                              //           : null),
                              //   child:
                              AnimatedContainer(
                                  height: 60,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                  decoration: BoxDecoration(
                                    color: isAnswerGiven &&
                                            qo[index] == selecteText
                                        ? isRightAnswer
                                            ? Colors.green
                                            : Colors.red
                                        : null, // added
                                    // border: Border.all(
                                    //     color: Colors.orange,
                                    //     width: 5), // added
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                        Border.all(color: Constants.greenColor),
                                  ),
                                  // color:
                                  //     isAnswerGiven && qo[index] == selecteText
                                  //         ? Colors.blue
                                  //         : Colors.red,
                                  child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          qo[index],
                                          style: TextStyle(
                                              color: qo[index] == selecteText
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16),
                                        )),
                                  )),
                        ))
                    /*     CustomButton1(
                          title: qo[index],
                          backColor: qo[index] == selecteText
                              ? Constants.greenColor
                              : null,
                          textColor: qo[index] == selecteText
                              ? Colors.white
                              : Colors.black,
                          onClickCallBack: () {
                            if (!isAnswerGiven) {
                              setState(() {
                                // btnSelected = index;
                                isAnswerGiven = true;
                                selecteText = qo[index];
                                q["value"] = selecteText;
                              });
                            }
                          },
                        ) 
                        )*/
                    )),

            // ButtonTypeAnswer(
            //   selectedIndex: selectedIndex,
            //   objQuestions: questions1,
            //   isSellerQuiz: true,
            // ),
          ],
        ));
  }

  Widget questionView() {
    // var screenHeight = MediaQuery.of(context).size.height;

    var dic = questions1[selectedIndex];
    return Card(
      color: Constants.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child:
          //  Container(
          //   // height: screenHeight * 0.25,
          //   padding: const EdgeInsets.only(bottom: 20),
          //   width: double.infinity,
          //   color: Constants.primaryColor,
          //   child:
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 30,
              ),
              child: Text(
                (selectedIndex + 1).toString() +
                    "/" +
                    questions1.length.toString(),
                style: TextStyle(color: Constants.greenColor, fontSize: 20),
              )),
          Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 30, right: 30, bottom: 20),
              child: Text(
                dic["question"],
                // textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontFamily: Constants.fontFamily,
                    fontWeight: FontWeight.w400),
              ))
        ],
      ),
      // )
    );
  }
}
