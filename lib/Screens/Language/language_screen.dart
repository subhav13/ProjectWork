import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/Languages.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/SignUP/SignUp.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:product/generated/i18n.dart';


class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  MyLanguagesList languagesList;

  @override
  void initState() {
    languagesList = new MyLanguagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
            S.current.languages, AppColor.white, 20.0, FontWeight.w500, 1),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("Assets/DoobiAssets/language_icon.png",
              height: 256,
              width: 256,

            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: MaterialButton(
                onPressed: (){

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Country List'),
                          content: setupAlertDialoadContainer(),
                        );
                      });


                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select your language"),
                    Icon(Icons.keyboard_arrow_down, color: Colors.black45),



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
                      new MaterialPageRoute(builder: (context) => new SignUpPage()));

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

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
          itemCount: languagesList.languages.length,
          itemBuilder: (context, index) {
            return new Container(
              // height: 70,
              padding: new EdgeInsets.only(
                  left: 15, right: 15, top: 2, bottom: 2),
              child: new InkWell(
                onTap: () {
                  setState(() async {
                    SharedManager.shared.locale.value =
                        Locale(languagesList.languages[index].code, '');
                    SharedManager.shared.currentIndex = 4;
                    SharedManager.shared.isFromTab = true;
                    Navigator.of(context).pop();
                   /* Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => TabBarScreen()),
                        ModalRoute.withName(AppRoute.tabbar));*/
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(languagesList
                                          .languages[index].flag))),
                            ),
                            SizedBox(width: 15),
                            setCommonText(
                                languagesList.languages[index].localName,
                                AppColor.black87,
                                18.0,
                                FontWeight.w400,
                                1)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 17, color: AppColor.black87)
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider()
                  ],
                ),
              ),
            );
          }),
    );
  }
}
