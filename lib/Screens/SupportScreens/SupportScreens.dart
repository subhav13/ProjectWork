import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/generated/i18n.dart';

void main() => runApp(new SupportScreen());

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
            S.current.support, AppColor.white, 20.0, FontWeight.w500, 1),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          AppImages.profileBackgroundImage),
                          fit: BoxFit.cover
                    ),
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(height: 180),
                      setCommonText(S.current.contactUs, AppColor.white, 20.0,
                          FontWeight.bold, 1)
                    ],
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppColor.white,
              padding: new EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.place, color: AppColor.red, size: 30),
                  SizedBox(height: 5),
                  Text(
                    '327, Colonel Mondjiba. Q/Basoko, C/ Gombe',
                    style: TextStyle(
                      color: AppColor.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Icon(Icons.mobile_screen_share,
                      color: AppColor.red, size: 30),
                  SizedBox(height: 5),
                  Text(
                    '+243815119855',
                    style: TextStyle(
                      color: AppColor.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Icon(Icons.computer, color: AppColor.red, size: 30),
                  SizedBox(height: 5),
                  Text(
                    '${S.current.email}:info@chaluka.app',
                    style: TextStyle(
                      color: AppColor.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Icon(Icons.watch_later, color: AppColor.red, size: 30),
                  SizedBox(height: 5),
                  Text(
                    'Monday to Friday',
                    style: TextStyle(
                      color: AppColor.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '08.30 to 16.00',
                    style: TextStyle(
                      color: AppColor.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Saturday and Sunday',
                    style: TextStyle(
                      color: AppColor.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'No Working',
                    style: TextStyle(
                      color: AppColor.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
