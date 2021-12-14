
import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Screens/CheckoutSequence/checkout_sequence.dart';




class ServiceType extends StatefulWidget {
  const ServiceType({Key key}) : super(key: key);

  @override
  _ServiceTypeState createState() => _ServiceTypeState();
}

class _ServiceTypeState extends State<ServiceType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(

        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
          //Todo translate
            "Service Type", AppColor.white, 20.0, FontWeight.w500, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
          Text("When would you like your laundry back",textAlign: TextAlign.center, style: TextStyle(
            fontWeight : FontWeight.bold, fontSize: 30
          ),
          
          ),

          const SizedBox(height: 25),
          MaterialButton(
              onPressed: () => {
              Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => new CheckOutSequence()))
              },
              child: Text("Normal Service \n24 Hours", textAlign: TextAlign.center),
            textColor: Colors.white,
            color: AppColor.themeColor,
            minWidth: MediaQuery.of(context).size.width / 2,
            height: 64,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36)
            ),
              )

          ],


        ),

      ),
    );
  }
}
