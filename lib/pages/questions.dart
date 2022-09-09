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
import 'package:pare/services/api_service.dart';
import 'package:pare/utils/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuestionsPage extends StatefulWidget {
  final String? username;
  final String? useremail;
  const QuestionsPage({Key? key, this.useremail, this.username})
      : super(key: key);
  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print("username >>>>> ${widget.username}");
    print("username >>>>> ${widget.useremail}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
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
      bottomNavigationBar: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (selectedIndex != 0)
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 0, bottom: 30),
                        child: bottomPreviousButton(Constants.greenColor, () {
                          setState(() {
                            if (selectedIndex != questions.length - 1) {
                              selectedIndex = selectedIndex - 1;
                            } else {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ThankYouPage(
                              //             isSellerQuiz: false,
                              //           )),
                              // );
                            }
                          });
                        }))),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 30, bottom: 30),
                      child: bottomNextButton(Constants.greenColor, () {
                        setState(() {
                          if (selectedIndex != questions.length - 1) {
                            selectedIndex = selectedIndex + 1;
                          } else {
                            // print(questions);
                            var dic = {"quiz_type": "Buyer"};

                            for (var i = 0; i < questions.length; i++) {
                              var q = questions[i];
                              if (q["value"] != "") {
                                dic["quiz[" + i.toString() + "][question]"] =
                                    q["id"].toString();
                                dic["quiz[" + i.toString() + "][ans]"] =
                                    q["value"];
                              }
                            }

                            print(dic);
                            sendDataToServer(dic);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ThankYouPage(
                            //             isSellerQuiz: false,
                            //           )),
                            // );
                          }
                        });
                      })))
            ],
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          questionView(),
          answerView(),
        ],
      )),
    );
  }

  sendDataToServer(Map<String, String> p) {
    print("getIntroFromServer");
    print(p);
    setState(() {
      // isDataLoading = true;
    });

    callAPI(context, ApiConstant.createQuiz, ApiConstant.postMethod, p, true)
        .then((response) {
      print(response);
      setState(() {});

      if (response != null) {
        if (response["status"] == 1) {
          for (var i = 0; i < questions.length; i++) {
            if (questions[i]["id"] == 12) {
              questions[i]["selected_index"] = [];
            }
            questions[i]["value"] = "";
          }

          showSnackBar(
              context, response["message"], "", SnackBarType.Sueecss, () {});
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ThankYouPage(
                        isSellerQuiz: false,
                      )));

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

  Widget answerView() {
    var q = questions[selectedIndex];
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        height: screenHeight * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (q["type"] == "input")
              InputTypeAnswer(
                  selectedIndex: selectedIndex,
                  useremail: widget.useremail,
                  username: widget.username),
            if (q["type"] == "button")
              ButtonTypeAnswer(
                selectedIndex: selectedIndex,
                objQuestions: questions,
                isSellerQuiz: false,
              ),
            if (q["type"] == "count")
              RoundButtonTypeAnswer(selectedIndex: selectedIndex),
            if (q["type"] == "radio")
              RadioTypeAnswer(
                selectedIndex: selectedIndex,
              ),
            const SizedBox(
              height: 50,
            ),
            if (q["type"] == "cardimage")
              CardImageTypeAnswer(
                selectedIndex: selectedIndex,
              )
          ],
        ));
  }

  Widget questionView() {
    // var screenHeight = MediaQuery.of(context).size.height;

    var dic = questions[selectedIndex];
    return Container(
      // height: screenHeight * 0.25,
      padding: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      color: Constants.greenColor,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                (selectedIndex + 1).toString() +
                    " - " +
                    questions.length.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: AutoSizeText(
                dic["question"],
                maxLines: 4,
                style: TextStyle(
                    fontSize: Constants.titleFontSize,
                    color: Colors.white,
                    fontFamily: Constants.fontFamily,
                    fontWeight: FontWeight.w300),
              )

              //  Text(
              //   dic["question"],
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       fontSize: 45,
              //       color: Colors.white,
              //       fontFamily: Constants.fontFamily,
              //       fontWeight: FontWeight.w300),
              // )
              )
        ],
      ),
    );
  }
}
