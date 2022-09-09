// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:munjiyasara_parivar/contast.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class ConnectivityService {
//   final GlobalKey<NavigatorState> navigatorKey =
//       new GlobalKey<NavigatorState>();
//   BuildContext context;

//   // Create our public controller
//   StreamController<bool> connectionStatusController = StreamController<bool>();

//   ConnectivityService() {
//     // Subscribe to the connectivity Chanaged Steam
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       // Use Connectivity() here to gather more info if you need t

//       print("Connection Changed..... $result");

//       if (result == ConnectivityResult.none) {
//         // isConnected = false;
//         showFlushBar(context, "No, Internet connection", "You are offline");
//       } else {
//         // isConnected = true;
//         // showFlushBar(context,"You are online");
//       }
//       // connectionStatusController.add(_getStatusFromResult(result));
//       // _getStatusFromResult(result);
//     });
//   }

//   // Convert from the third part enum to our own enum
//   bool _getStatusFromResult(ConnectivityResult result) {
//     SharedPreferences.getInstance().then((preference) {
//       switch (result) {
//         case ConnectivityResult.none:
//           // if (preference.getBool(Preferences.is_splash) == true &&
//           //     preference.getBool(Preferences.is_onBoarding) == true) {
//           //   navigatorKey.currentState.pushReplacementNamed(Routes.noInternet);
//           // }
//           // navigatorKey.currentState.pushReplacementNamed(Routes.no_internet);
//           // Navigator.of(BuildContext context).pushReplacement(MaterialPageRoute(
//           //   builder: (context) => NoInternet(),
//           // ));
//           return false;

//         default:
//           // if (preference.getBool(Preferences.is_splash) == true &&
//           //     preference.getBool(Preferences.is_onBoarding) == true) {
//           //   if (preference.getBool(Preferences.is_logged_in) == true) {
//           //     navigatorKey.currentState.pushNamedAndRemoveUntil(
//           //         Routes.dashboard, (Route<dynamic> route) => false);
//           //   } else {
//           //     navigatorKey.currentState.pushNamedAndRemoveUntil(
//           //         Routes.login, (Route<dynamic> route) => false);
//           //   }
//           // }

//           // if (preference.getBool(Preferences.is_logged_in) == true) {
//           //   navigatorKey.currentState.pushNamed(Routes.home);
//           // } else {
//           //   navigatorKey.currentState.pushNamed(Routes.login);
//           // }
//           return true;
//       }
//     });
//   }

//   bool isValid() {}
// }
