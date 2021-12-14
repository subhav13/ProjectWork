import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Screens/ServiceType/service_type.dart';
import 'package:product/generated/i18n.dart';
class DashBoard extends StatelessWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
            S.current.home, AppColor.white, 20.0, FontWeight.w500, 1),
      ),
      body: Column(

        children: [
          Image.asset("Assets/DoobiAssets/doobi_dashboard.png"),
          Align(
            alignment: Alignment.center,
            child: setCommonText("Services",
                AppColor.black,
                25.0,
                FontWeight.bold,
                1),
          ),

          SizedBox(height: 10,),
          Align(
            alignment: Alignment.centerLeft,
            child: setCommonText("  Order Type",
                AppColor.black,
                20.0,
                FontWeight.bold,
                1),
          ),
          SizedBox(height: 15,),
          Align(
            alignment: Alignment.center,
            child: setCommonText("Select your Order Type",
                Colors.indigo,
                20.0,
                FontWeight.bold,
                1),
          ),
          SizedBox(height: 15),
          Expanded(
            flex: 1,
            child: InkWell(
                onTap: (){

                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => new ServiceType()));
                },
                child: Image.asset("Assets/DoobiAssets/easy_button.png")

            ),
          ),
          SizedBox(height: 5),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){},
                child: Image.asset("Assets/DoobiAssets/enter_item.png")

            ),
          ),



        ],
      ),
    );
  }
}
