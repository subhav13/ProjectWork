import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Screens/ChangeAddress/ChangeAddress.dart';
import 'package:product/generated/i18n.dart';

class CheckOutSequence extends StatefulWidget {
  const CheckOutSequence({Key key}) : super(key: key);

  @override
  _CheckOutSequenceState createState() => _CheckOutSequenceState();
}

class _CheckOutSequenceState extends State<CheckOutSequence> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
            S.current.shcedule_pickup, AppColor.white, 20.0, FontWeight.w500, 1),
      ),

      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              physics: ScrollPhysics(),
              currentStep: _currentStep,
              steps: [
                Step(
                  title: Text("Location"),
                  content: ChangeAddress(),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0 ? StepState.complete : StepState.disabled

                ),
                Step(
                    title: Text("Date/Time"),
                    content: Text("Location"),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ? StepState.complete : StepState.disabled


                ),

                Step(
                    title: Text("Payment"),
                    content: Text("Location"),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ? StepState.complete : StepState.disabled

                ),

                Step(
                    title: Text("Complete"),
                    content: Text("Location"),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ? StepState.complete : StepState.disabled

                ),
              ],
            ),
          )
        ],
      ),


    );
  }


  tapped(int step ){
    setState(() {
      _currentStep = step;
    });
  }


  continued(){
    _currentStep < 3 ?  setState(() => _currentStep += 1) : null ;
  }

 cancel(){
    _currentStep > 0 ?  setState(() => _currentStep -= 1) : null ;
 }
}
