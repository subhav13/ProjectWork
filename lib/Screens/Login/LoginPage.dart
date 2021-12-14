import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/LocationManager.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/ForgotPassword/forgotPassword.dart';
import 'package:product/Screens/SignUP/SignUp.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:http/http.dart' as http;
import 'package:product/generated/i18n.dart';

import 'SocialLogin/sign_in.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var width = 40.0;
  var height = 40.0;
  var status = true;

  var widthgp = 40.0;
  var heightgp = 40.0;
  var statusgp = true;
  /*Charmides*/
  var _selectedUserType = 0;
  static TextEditingController emailController = new TextEditingController();
  static TextEditingController passwordController = new TextEditingController();
  bool isSecure = true;
  static double latitude = 0.00;
  static double longitude = 0.00;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
//Social Media Integrations for login.

//Facebook Login Stuff

  Future<Null> _loginWithFacebook() async {
    final FacebookLoginResult result =
        await SharedManager.shared.facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${accessToken.token}');
        var profile = json.decode(graphResponse.body);
        var data = profile['picture']['data'];
        print("User Facebook Response:$profile");
        _loginWithSocialMedia(
            '0', profile['name'], profile['email'], profile['id'], data['url']);
        break;
      case FacebookLoginStatus.cancelledByUser:
        // _showMessage('Login cancelled by the user.');
        print('Login cancelled by the user');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

//TODO: Social Media Login

  _loginWithSocialMedia(
      String type, String name, String email, String id, String image) async {
    final param = {
      "email": email,
      "name": name,
      "phone": "123456",
      "latitude": "${SharedManager.shared.latitude}",
      "longitude": "${SharedManager.shared.longitude}",
      "social_id": id,
      "is_social_login": '1',
      "device_token": '${SharedManager.shared.token}',
      "profile_image": '$image'
    };
    print('User Parameters:======>$param');

    showSnackbar("${S.current.loading}", _scaffoldkey);
    Requestmanager manager = Requestmanager();
    await manager
        .getUserLoginWithSocialMedia(APIS.socialLogin, true, param)
        .then((value) async {
      _scaffoldkey.currentState.hideCurrentSnackBar();
      if (value.code == 1) {
        await SharedManager.shared.storeUserSocialLoginData(value);
        emailController.text = '';
        passwordController.text = '';
        await SharedManager.shared.storeString("yes", "isLoogedIn");
        await SharedManager.shared.storeString("yes", "isSocialLogin");
        SharedManager.shared.isLoggedIN = "yes";
        Navigator.pop(context);
        SharedManager.shared.currentIndex = 2;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TabBarScreen()),
            ModalRoute.withName(AppRoute.tabbar));
      } else {
        SharedManager.shared.showAlertDialog(value.message, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    LocationManager.shared.getCurrentLocation();
    _getUserCurrentLocation();
    emailController.text = "";
  }
  // var facebookLogin = FacebookLogin();

  _getUserCurrentLocation() async {
    LatLng coordinate = await SharedManager.shared.getLocationCoordinate();
    latitude = coordinate.latitude;
    longitude = coordinate.longitude;
  }

  _setLoginMethod() async {
    var validator = SharedManager.shared.validateEmail(emailController.text);

    if (emailController.text == "" || validator == "Enter Valid Email") {
      Navigator.pop(context);
      SharedManager.shared
          .showAlertDialog("${S.current.enterEmailFirst}", context);
      return;
    } else if (passwordController.text == "") {
      Navigator.pop(context);
      SharedManager.shared
          .showAlertDialog("${S.current.enterOldpass}}", context);
      return;
    }

    var param = {
      "email": emailController.text,
      "password": passwordController.text,
      "device_token": SharedManager.shared.token,
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
    };

    print("Request Parameter:$param");

    var manager = Requestmanager();
    var data = await manager.getUserLogin(APIS.login, true, param);
    print("User data: ===== >>>>>>${data.code}");
    if (data.code == 1) {
      emailController.text = '';
      passwordController.text = '';
      await SharedManager.shared.storeString("yes", "isLoogedIn");
      await SharedManager.shared.storeString("no", "isSocialLogin");
      await SharedManager.shared.storeUserLoginData(data);
      SharedManager.shared.isLoggedIN = "yes";
      Navigator.pop(context);
      SharedManager.shared.currentIndex = 2;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TabBarScreen()),
          ModalRoute.withName(AppRoute.tabbar));
    } else {
      Navigator.pop(context);
      SharedManager.shared.showAlertDialog(data.message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldkey,
      body: Container(
        color: Colors.indigo.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              // color: AppColor.red,
              child: Image.asset("Assets/DoobiAssets/doobi_logo.png",
                width: MediaQuery.of(context).size.width,
                height: 150,
              ),
            ),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Padding(

                padding: EdgeInsets.only(right: 20, left: 20),
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  // color: AppColor.amber,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Container(
                        // height: 60,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                    borderSide: BorderSide(color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey,

                                  border: InputBorder.none,
                                  hintText: '${S.current.email}'),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.black,
                                  fontFamily:
                                      SharedManager.shared.fontFamilyName),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // height: 60,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: this.isSecure ? true : false,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                          borderSide: BorderSide(color: Colors.white, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey,
                                        border: InputBorder.none,
                                        hintText: '${S.current.password}'),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black,
                                        fontFamily: SharedManager
                                            .shared.fontFamilyName),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                new Radio(
                                  value: 0,
                                  groupValue: _selectedUserType,
                                  onChanged: (value) => _handleRadioButtonSelection(value)
                                ),
                                new Text(
                                  'Individual',
                                  style: new TextStyle(
                                      fontSize: 24.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _selectedUserType,
                                  onChanged: (value) => _handleRadioButtonSelection(value),
                                ),
                                new Text(
                                  'Corporate',
                                  style: new TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                                // InkWell(
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 ForgotPassword()));
                                //   },
                                //   child: setCommonText(
                                //       '${S.current.forgotPassword}',
                                //       AppColor.grey,
                                //       14.0,
                                //       FontWeight.w500,
                                //       1),
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          _setLoginMethod();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColor.themeColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: setCommonText('${S.current.login}',
                                AppColor.white, 16.0, FontWeight.bold, 1),
                          ),
                        ),
                      ),

                    SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                setCommonText('${S.current.dont_have_account}',
                    AppColor.grey, 20.0, FontWeight.w500, 1),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    //SignUpPage
                    //OTPVerificationPage
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpPage(
                          isFromLoginPage: true,
                        )));
                  },
                  child: setCommonText('${S.current.register}',
                      AppColor.white, 20.0, FontWeight.bold, 1),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  _handleRadioButtonSelection(int value){
    setState(() {

      _selectedUserType = value;
    });
  }
}
