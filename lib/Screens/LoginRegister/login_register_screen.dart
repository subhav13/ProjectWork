
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Screens/Location/location_screen.dart';
import 'package:product/Screens/Login/LoginPage.dart';
import 'package:product/Screens/SignUP/SignUp.dart';
class LoginRouteScreen extends StatefulWidget {
  const LoginRouteScreen({Key key}) : super(key: key);

  @override
  _LoginRouteScreenState createState() => _LoginRouteScreenState();
}

class _LoginRouteScreenState extends State<LoginRouteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      
      SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(

                  AppImages.loginImage,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
              ),
            ),
  
          SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => new LoginPage()));

                  },
                  height: 54,
                  child: Text("Login"),
                  color: Colors.white,
                  minWidth: 128,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                ),

                MaterialButton(
                  onPressed: () {

                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => new LocationScreen()));

                  },
                  child: Text("Register"),
                  color: Colors.indigo,
                  textColor: Colors.white,
                  minWidth: 128,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                  height: 54,
                )

              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
