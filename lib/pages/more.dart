import 'package:flutter/material.dart';
import 'package:pare/pages/help.dart';
import 'package:pare/pages/login.dart';
import 'package:pare/pages/questions.dart';
import 'package:pare/pages/questions1.dart';
import 'package:pare/pages/thankyou.dart';
import 'package:pare/services/shared_preference.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String userType = "Buyer";
  String userName = "";
  String userEmail = "";

  onClickLogout() {
    StorageHelper.clearAll();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false);
  }

  getUserType() async {
    if (await StorageHelper.get(Preferences.userType) == "Buyer") {
      setState(() {
        userType = "Buyer";
      });
    } else {
      setState(() {
        userType = "Seller";
      });
    }

    await StorageHelper.get(Preferences.userEmail).then((value) => {
          setState(() {
            userEmail = value;
          })
        });
    await StorageHelper.get(Preferences.userName).then((value) => {
          setState(() {
            userName = value;
          })
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserType();
  }

  Widget headerText(String txt) {
    return Text(
      txt,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (userType == "Buyer")
        ListTile(
            onTap: () {
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(
              //         builder: (context) => ThankYouPage(
              //               isSellerQuiz: false,
              //             )),
              //     (Route<dynamic> route) => false);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionsPage(
                          useremail: userEmail,
                          username: userName,
                        )),
              );
            },
            title: headerText("Survey"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 1,
              ),
            )),
        // if (userType != "Buyer")
        ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Questions1Page()),
              );
            },
            title: headerText("Quiz"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            subtitle: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Divider(
                  thickness: 1,
                ))),
        ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HelpPage(
                          useremail: userEmail,
                          username: userName,
                        )),
              );
            },
            title: headerText("Help me find an agent"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            subtitle: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Divider(
                  thickness: 1,
                ))),
        ListTile(
            onTap: () {
              onClickLogout();
            },
            title: headerText("Logout"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            subtitle: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Divider(
                  thickness: 1,
                )))
      ],
    );
  }
}
