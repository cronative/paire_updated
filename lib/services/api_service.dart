import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pare/services/shared_preference.dart';

import '../utils/constant.dart';
import 'api_exception.dart';

// import 'package:timeclockwizard/helper/constant.dart';
// import 'package:timeclockwizard/helper/shared_preference.dart';
// import 'package:timeclockwizard/model/loginResponse.dart';
// import 'package:timeclockwizard/services/api_exception.dart';

Map errorMessage = {};

class ApiService {
  static _returnResponse(http.Response response, BuildContext context) {
    errorMessage = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        showSnackBar(
            context,
            errorMessage['message'] != null
                ? errorMessage['message']
                : response.body.toString(),
            "",
            SnackBarType.Error,
            () {});
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        showSnackBar(
            context,
            errorMessage['message'] != null
                ? errorMessage['message']
                : response.body.toString(),
            "",
            SnackBarType.Error,
            () {});
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        showSnackBar(
            context,
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
            "",
            SnackBarType.Error,
            () {});
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class ApiConstant {
  ApiConstant(_);
  // static String baseUrl = "http://appyardz.com/munjiyasara/api/";
  static String getMethod = "get";
  static String postMethod = "post";
  static String googleStore = "http://vrdev.storage.googleapis.com/";
  static String baseUrl = "http://13.127.111.30/api/";
  static String youtube = "http://www.vocalreferences.com/api/";
//static String APP_DOMAIN = "http://test.vocalreferences.com/vrapp/api/"
//static String YOUTUBE = "http://test.vocalreferences.com/api/"
  static String login = "login";
  static String signUp = "signup";
  static String socialLogin = "social_login";
  static String createQuiz = "quiz/create";
  static String imageLike = "image/like";
  static String quizScrore = "quiz/score";
  static String forgotPassword = "forgot-password";

  static String changePassword = "change-password";
  static String verifyOtp = "check-otp";

  static String logout = "logout";
  static String images = "images?type=";
//   static String socialLogin = "user/authBySocial/";
//   static String signUp = "user/signup/";
//   static String resetPassword = "user/resetpassword/";
//   static String getIntro = "content/getIntroVideo";
//   static String updateProfile = "user/profileupdate?auth_token=";
//   static String getProfile = "user/getprofile?auth_token=";
//   static String getAllvss = "vss/getVSS?auth_token=";
//   static String getUserVss = "vss/getVSSUser?auth_token=";
//   static String setVss = "vss/addVSSUser?auth_token=";
//   static String editVss = "vss/editVSSUser?auth_token=";
// //static String GET_CLOUD_LINK = "http://test.vr-cloud-1.appspot.com/getLink.php"
//   static String getCloudLink = "http://prod.vr-cloud-1.appspot.com/getLink.php";
//   static String addRecord = "content/addAndroid?auth_token=";
//   static String editRecord = "content/editAndroid?auth_token=";
//   static String getAllRecords =
//       "content/mine?page_number=1&page_size=10000&auth_token=";
//   static String deleteRecord = "content/deleteAndroid?auth_token=";
//   static String setFavorite = "content/setFavorite?auth_token=";
//   static String changePassword = "user/changePassword?auth_token=";
//   static String changeUserPassword = "user/changeProfileVideo?auth_token=";
//   static String upgrade = "user/upgrade?auth_token=";
//   static String verifyReceipt = "user/verifySignature?deviceType=ios";
//   static String getViewsCount = "content/getCountReviews?auth_token=";
}

class NewApiConstant {
  NewApiConstant(_);
  static String baseUrl = "https://api.vocalreferences.com/v4/";
  static String login = "login";
  static String signUp = "sign-up";
  static String changePassword = "change-password";
  static String recovery = "recovery";
  static String uploadToCloud = "upload-to-cloud";
  static String profile = "profile";
  static String updateProfile = "profile/update";
  static String changeProfileImage = "profile/change-avatar";
  static String getTestimonials = "content";
  static String getTestimonailDetails = "content/view";
  static String createTestimonial = "content/create";
  static String updateTestimonial = "content/update";
  static String approveTestimonial = "content/approve";
  static String deleteTestimonial = "content/delete";
}

Future callAPI(BuildContext _context, String action, String method,
    Map<String, String> params, bool isLoaderShow) async {
  if (isLoaderShow) {
    showLoader(_context);
  }

  var strURL = ApiConstant.baseUrl + action;
  var encodeUrl = Uri.parse(strURL);
  print(encodeUrl);
  print(params);

  final encoding = Encoding.getByName('utf-8');

  String authToken = "";
  if (await StorageHelper.get(Preferences.authToken) != null) {
    await StorageHelper.get(Preferences.authToken).then((value) {
      // ignore: avoid_print
      print("Auth Token");
      print(value);
      authToken = value;
    });
  }

  Map<String, String> headers = {"token": authToken};

  if (method == ApiConstant.getMethod) {
    http.Response response = await http.get(
      encodeUrl,
      headers: headers,
    );
    var r;
    if (200 == response.statusCode) {
      r = utf8.decode(response.bodyBytes);
      // r = response.bodyBytes;
      print(r);
      hideLoader();
      return jsonDecode(r);
    } else {
      r = response.bodyBytes;
      hideLoader();
      ApiService._returnResponse(response, _context);
      return jsonDecode(r);
    }
  } else {
    var request = http.MultipartRequest('POST', encodeUrl)
      ..fields.addAll(params);
    request.headers.addAll(headers);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (200 == response.statusCode) {
      hideLoader();
    } else {
      hideLoader();
    }
    print(jsonDecode(respStr));
    return jsonDecode(respStr);

    // http.Response response = await http.post(
    //   encodeUrl,
    //   body: jsonEncode(params),
    //   encoding: encoding,
    //   // headers: {
    //   //   "Authorization": "Bearer aBSgNsZi6ZoLein83Tx1gAcnfn6a6-BWnUxJiriG"
    //   // }
    // );
    // var r;
    // if (200 == response.statusCode) {
    //   r = response.body;
    //   hideLoader();
    //   return jsonDecode(r);
    // } else {
    //   r = response.body;
    //   hideLoader();
    //   ApiService._returnResponse(response, _context);
    //   return jsonDecode(r);
    // }
  }
}

Future callAPI1(BuildContext _context, String action, String method,
    Map<dynamic, dynamic> params, bool isLoaderShow) async {
  if (isLoaderShow) {
    showLoader(_context);
  }

  var strURL = action;
  var encodeUrl = Uri.parse(strURL);
  print(encodeUrl);
  print(params);

  final encoding = Encoding.getByName('utf-8');

  if (method == ApiConstant.getMethod) {
    http.Response response = await http.get(
      encodeUrl,
      // headers: objHeader,
    );
    var r;
    if (200 == response.statusCode) {
      r = utf8.decode(response.bodyBytes);
      // r = response.bodyBytes;
      print(r);
      hideLoader();
      return jsonDecode(r);
    } else {
      r = response.bodyBytes;
      hideLoader();
      ApiService._returnResponse(response, _context);
      return jsonDecode(r);
    }
  } else {
    http.Response response = await http.post(encodeUrl,
        body: jsonEncode(params), encoding: encoding);
    var r;
    if (200 == response.statusCode) {
      r = response.body;
      hideLoader();
      return jsonDecode(r);
    } else {
      r = response.body;
      hideLoader();
      ApiService._returnResponse(response, _context);
      return jsonDecode(r);
    }
  }
}

OverlayState? overlayState;
OverlayEntry? overlayEntry;

showLoader(BuildContext context) async {
  overlayState = Overlay.of(context);

  if (overlayEntry == null) {
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: <Widget>[
          Container(
            color: Colors.black12,
          ),
          Positioned(
            child: Center(
              child: Container(
                  // color: Colors.white,
                  child: CircularProgressIndicator()
                  //  Image(
                  //   width: 120,
                  //   height: 120,
                  //   image: AssetImage('assets/images/app_icon.png'),
                  // ),
                  ),
            ),
          ),
        ],
      ),
    );
    overlayState!.insert(overlayEntry!);
  }
}

hideLoader() {
  if (overlayEntry != null) {
    overlayEntry!.remove();
    overlayEntry = null;
  }
}
