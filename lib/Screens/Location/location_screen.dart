import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Screens/Language/language_screen.dart';
import 'package:product/generated/i18n.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
            S.current.location, AppColor.white, 20.0, FontWeight.w500, 1),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("Assets/DoobiAssets/location_icon.png",
              height: 256,
              width: 256,

            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: MaterialButton(
                  onPressed: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select a location"),
                    Icon(Icons.my_location, color: Colors.black45),



                  ],
                ),

                color: Colors.white70,
                textColor: Colors.black,

                minWidth: MediaQuery.of(context).size.width ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                height: 32,
                  ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),

              child: MaterialButton(
                onPressed: () {

                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => new LanguageScreen()));

                },
                child: Text("Done"),
                color: Colors.indigo,
                textColor: Colors.white,
                minWidth: MediaQuery.of(context).size.width ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                height: 48,
              ),
            )

          ],
          
        ),
      ),
    );
  }
}
