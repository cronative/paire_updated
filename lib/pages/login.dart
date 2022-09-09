import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pare/pages/forgotpassword.dart';
import 'package:pare/pages/signup.dart';
import 'package:pare/pages/tabbar.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import '../services/api_service.dart';
import '../services/shared_preference.dart';
import '../utils/auth.dart';
import '../utils/constant.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController? txtEmail = TextEditingController();
  TextEditingController? txtPassword = TextEditingController();

  goToHomeScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const TabbarPage()),
        (Route<dynamic> route) => false);
  }

  Future<User?> signInWithGoogle() async {
    print("signInWithGoogle");
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    print(googleSignIn);

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    print(googleSignInAccount);

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      goToHomeScreen();

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  checkValidation() {
    if (txtEmail!.text.isEmpty) {
    } else if (txtPassword!.text.isEmpty) {
    } else if (txtPassword!.text.isEmpty) {
    } else {
      // signUpwithEmail(txtEmail!.text, txtPassword!.text);
    }
  }

  //SIGN UP METHOD
  signUpwithEmail({String? email, String? password}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((result) {
        if (result == null) {
        } else {
          goToHomeScreen();
        }
      });
      ;
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  onClickSubmit() {
    print("getIntroFromServer");
    setState(() {
      // isDataLoading = true;
    });
    Map<String, String> param = {
      "email": txtEmail!.text,
      "password": txtPassword!.text,
      "ip_address": "129.0.0.1",
      "device": "Realme XT",
      "device_id": "DHFGJSH584SD46F5",
    };

    callAPI(context, ApiConstant.login, ApiConstant.postMethod, param, true)
        .then((response) {
      print(response);
      setState(() {});

      if (response != null) {
        if (response["status"] == 1) {
          StorageHelper.set(Preferences.isLoggedIn, "true");
          StorageHelper.set(Preferences.authToken, response["data"]["token"]);
          StorageHelper.set(
              Preferences.userId, response["data"]["id"].toString());
          StorageHelper.set(
              Preferences.userType, response["data"]["type"].toString());
          StorageHelper.set(
              Preferences.userEmail, response["data"]["email"].toString());
          StorageHelper.set(
              Preferences.userName, response["data"]["name"].toString());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const TabbarPage()),
              (Route<dynamic> route) => false);
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
    double height = MediaQuery.of(context).size.height;
    print(height);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Constants.primaryColor,
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              // child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 200,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 20),
                                  //   child: AutoSizeText(
                                  //     Constants.strLetsGetStarted,
                                  //     minFontSize: 35,
                                  //     maxFontSize: 45,
                                  //     style: TextStyle(
                                  //         letterSpacing: 1.3,
                                  //         // fontSize: 50,
                                  //         fontFamily: Constants.fontFamily,
                                  //         color: Constants.greenColor,
                                  //         fontWeight: FontWeight.w300),
                                  //   ),
                                  // ),
                                  AutoSizeText(
                                    Constants.strHello,
                                    minFontSize: 30,
                                    maxFontSize: 40,
                                    style: TextStyle(
                                        // fontSize: 40,
                                        color: Constants.greenColor,
                                        fontFamily: Constants.fontFamily,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: AutoSizeText(
                                      Constants.strThere,
                                      minFontSize: 25,
                                      maxFontSize: 32,
                                      style: TextStyle(
                                          // letterSpacing: 1.3,
                                          // fontSize: 35,
                                          fontFamily: Constants.fontFamily,
                                          color: Constants.greenColor,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 7,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    Constants.img2,
                                    height: height / 3,
                                  ))),
                        ],
                      ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Image.asset(
                      //     Constants.img2,
                      //     height: 400,
                      //   ),
                      // ),

                      Text(
                        Constants.strEnteryour.toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 20,
                            height: 1.2,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        textEditingController: txtEmail,
                        title: Constants.strEmailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          } else if (!checkEmailValid(value)) {
                            return 'Please enter valid email address';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        textEditingController: txtPassword,
                        title: Constants.strPassword,
                        isPasswordField: true,
                        isSecureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      // Padding(
                      //     padding: const EdgeInsets.only(top: 10),
                      //     child: TextButton(
                      //         onPressed: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     const ForgotPasswordPage()),
                      //           );
                      //         },
                      //         child: Text(
                      //           "Forgot Password?",
                      //           style: TextStyle(
                      //               color: Constants.greenColor, fontSize: 16),
                      //         ))),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomButton(
                              title: "LOGIN",
                              onClickCallBack: () {
                                if (_formKey.currentState!.validate()) {
                                  onClickSubmit();
                                }
                              })),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      // CustomTextField(
                      //   title: Constants.strConfirmPassword,
                      //    isPasswordField: true,
                      //   isSecureText: true,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   children: [
                      //     // roundSocialButton(Icons.facebook_sharp),
                      //     Padding(
                      //         padding: const EdgeInsets.only(left: 10),
                      //         child: roundSocialButton(Icons.g_mobiledata, () {
                      //           // _handleSignIn();
                      //           signInWithGoogle();
                      //         })
                      //         // FutureBuilder(
                      //         //   future: Authentication.initializeFirebase(
                      //         //       context: context),
                      //         //   builder: (context, snapshot) {
                      //         //     if (snapshot.hasError) {
                      //         //       return const Text('Error initializing Firebase');
                      //         //     } else if (snapshot.connectionState ==
                      //         //         ConnectionState.done) {
                      //         //       return roundSocialButton(Icons.g_mobiledata, () {
                      //         //         _handleSignIn();
                      //         //       });
                      //         //     }
                      //         //     return const CircularProgressIndicator();
                      //         //     // return CircularProgressIndicator(
                      //         //     //   valueColor: AlwaysStoppedAnimation<Color>(
                      //         //     //     // Palette.firebaseOrange,
                      //         //     //   ),
                      //         //     // );
                      //         //   },
                      //         // ),
                      //         ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 10),
                      //       child: roundSocialButton(Icons.apple, () {}),
                      //     )
                      //   ],
                      // ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 10),
                      //     child: nxtButton(() {
                      //       // goToHomeScreen();
                      //       if (_formKey.currentState!.validate()) {
                      //         onClickSubmit();
                      //       }
                      //     }, Constants.secondaryColor, true),
                      //   ),
                      // )
                    ],
                  ))),
        ));
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}
