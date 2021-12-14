import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class OTPVerificationPage extends StatefulWidget {
  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getCustomerDeatils();
  }

  _getCustomerDeatils() async {
    // await SharedManager.shared.get(DefaultKeys.userId).then((value) {
    //   print(value);
    // });
    // await SharedManager.shared.get(DefaultKeys.userPhone).then((value) {
    //   print(value);
    // });
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    //verify OTP request

    print("The OTP code is:->${this._otpCode}");
    final userId = await SharedManager.shared.userId();

    final param = {
      "otp": "${this._otpCode}",
      "customer_id": '$userId',
    };

    print('Verify OTP Parameters:$param');

    showSnackbar('Loading...', _scaffoldkey);
    Requestmanager manager = Requestmanager();
    await manager.verifyMobileOTP(param, context).then((value) async {
      _scaffoldkey.currentState.hideCurrentSnackBar();
      if (value) {
        await SharedManager.shared.storeString("yes", "isLoogedIn");
        SharedManager.shared.isLoggedIN = "yes";
        Navigator.pop(context);
        (SharedManager.shared.isFromCart)
            ? SharedManager.shared.currentIndex = 3
            : SharedManager.shared.currentIndex = 2;
        (SharedManager.shared.isFromCart)
            ? SharedManager.shared.isFromTab = true
            : SharedManager.shared.isFromTab = false;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TabBarScreen()),
            ModalRoute.withName(AppRoute.tabbar));
      } else {
        // SharedManager.shared.showAlertDialog(
        //     "Somethings goes wrong,Please try after sometime", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldkey,
      body: Container(
        color: AppColor.white,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  setHeight(115),
                  setCommonText('Phone Verification', AppColor.black, 25.0,
                      FontWeight.w700, 1),
                  setCommonText('Enter OTP here', AppColor.black87, 14.0,
                      FontWeight.w400, 3),
                  setHeight(15),
                  setCommonText('Enter 1234 OTP for testing.', AppColor.orange,
                      12.0, FontWeight.w400, 3),
                  setHeight(40),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                        // color: AppColor.grey[300],
                        ),
                    child: TextFieldPin(
                      filled: true,
                      filledColor: AppColor.themeColor,
                      codeLength: _otpCodeLength,
                      boxSize: 50,
                      filledAfterTextChange: false,
                      textStyle: TextStyle(fontSize: 16),
                      borderStyle: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(28)),
                      onOtpCallback: (code, isAutofill) =>
                          _onOtpCallBack(code, isAutofill),
                    ),
                  ),
                  setHeight(50),
                  setCommonText('Don\'t you received any code?', AppColor.grey,
                      14.0, FontWeight.w400, 3),
                  InkWell(
                    onTap: () {},
                    child: setCommonText('Resend a new code', Colors.green,
                        13.0, FontWeight.w400, 3),
                  ),
                  setHeight(50),
                  InkWell(
                    onTap: () {
                      if (_enableButton) {
                        _onSubmitOtp();
                      } else {
                        SharedManager.shared
                            .showAlertDialog('Enter Valid OTP first', context);
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.themeColor,
                        ),
                        child: Center(
                          child: setCommonText('Verify', AppColor.white, 16.0,
                              FontWeight.w500, 1),
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 45,
                left: 15,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.red,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
