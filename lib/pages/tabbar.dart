import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:pare/pages/more.dart';
import 'package:pare/pages/seller.dart';
import 'package:pare/utils/constant.dart';

import '../services/shared_preference.dart';
import 'buyer.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class TabbarPage extends StatefulWidget {
  const TabbarPage({Key? key}) : super(key: key);
  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  late int currentIndex;
  String userType = "Buyer";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserType();
    currentIndex = 0;
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
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.greenColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          Constants.imgLogo,
          width: 150,
        ),
        // title: Text(widget.title),
      ),
      body: currentIndex == 0 && userType == "Buyer"
          ? const BuyerPage()
          : currentIndex == 0 && userType != "Buyer"
              ? const SellerPage()
              : MenuPage(),
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: false,
        // fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        backgroundColor: Constants.greenColor,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        tilesPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        items: <BubbleBottomBarItem>[
          if (userType == "Buyer")
            BubbleBottomBarItem(
              // showBadge: true,
              // badge: Text("5"),
              // badgeColor: Colors.deepPurpleAccent,
              backgroundColor: Constants.primaryColor,
              icon: const Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              activeIcon: const Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              title: const Text(
                "Buyer",
                style: TextStyle(color: Colors.white),
              ),
            ),
          if (userType != "Buyer")
            BubbleBottomBarItem(
                backgroundColor: Constants.primaryColor,
                icon: const Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                activeIcon: const Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                title: const Text(
                  "Seller",
                  style: TextStyle(color: Colors.white),
                )),
          BubbleBottomBarItem(
              backgroundColor: Constants.primaryColor,
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              activeIcon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              title: const Text(
                "Menu",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
