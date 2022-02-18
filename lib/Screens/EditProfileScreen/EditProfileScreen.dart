import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:product/generated/i18n.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String number;
  final String image;

  EditProfileScreen({this.name, this.email, this.number, this.image});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var isLoginwithSocialMedia = '';

  bool isLogin = false;
  File _image;
  final picker = ImagePicker();
  bool isImageAdded = false;
  String imageString = '';
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  _getImageStringFromUrl(String imageUrl) async {
    http.Response response = await http.get(
      Uri.parse(imageUrl),
    );
    this.imageString = base64.encode(response.bodyBytes);
    isImageAdded = true;
  }

  @override
  void initState() {
    super.initState();
    _getUserStoredData();
    _getImageStringFromUrl(this.widget.image);
  }

  _getUserStoredData() async {
    isLoginwithSocialMedia = await SharedManager.shared.get('isSocialLogin');
    nameController.text = this.widget.name;
    emailController.text = this.widget.email;
    mobileController.text = this.widget.number;

    print('Login Status:$isLoginwithSocialMedia');
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 350.0, maxWidth: 350.0);

    setState(() {
      isImageAdded = true;
      _image = File(pickedFile.path);
    });

    Im.Image image = Im.decodeJpg(_image.readAsBytesSync());
    List<int> imageBytes = Im.PngEncoder().encodeImage(image);
    imageString = base64Encode(imageBytes);
    print('$imageString');
  }

  _updateProfile() async {
    final param = {
      "fullname": "${nameController.text}",
      "id": SharedManager.shared.userID,
      "phone": "${mobileController.text}",
      "image": "$imageString"
    };
    print('Update Pdofile Parameters:=>$param');

    if (nameController.text == "") {
      SharedManager.shared.showAlertDialog('Please Enter Name', context);
      return;
    } else if (mobileController.text == "") {
      SharedManager.shared
          .showAlertDialog('Please Enter valid number', context);
      return;
    }

    showSnackbar('${S.current.loading}', scaffoldKey);
    Requestmanager manager = Requestmanager();
    await manager.updateProfileData(param).then((value) {
      scaffoldKey.currentState.hideCurrentSnackBar();
      if (value.code == 1) {
        SharedManager.shared
            .showAlertDialog('Profile Update Successfully', context);
        SharedManager.shared.currentIndex = 4;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TabBarScreen()),
            ModalRoute.withName(AppRoute.tabbar));
      } else {
        SharedManager.shared.showAlertDialog('${value.message}', context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: setCommonText('${S.current.editProfile}', AppColor.white, 20.0,
            FontWeight.w500, 1),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
        leading: IconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: AppColor.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        color: AppColor.white,
        child: ListView(
          children: <Widget>[
            Container(
              height: 180,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: AppColor.grey[300]),
                      borderRadius: BorderRadius.circular(50)),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage('${this.widget.image}'),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: _image == null
                                ? Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${this.widget.image}'),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          )),
                      Positioned(
                          bottom: 3,
                          right: 3,
                          child: InkWell(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.themeColor,
                                  border: Border.all(
                                      width: 2, color: AppColor.grey[300])),
                              child: Icon(
                                Icons.edit,
                                size: 12,
                                color: AppColor.white,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // color: AppColor.red,
              padding: new EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText('${S.current.fullName}', AppColor.black87,
                            15.0, FontWeight.w500, 1),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(hintText: 'name'),
                          style: TextStyle(
                              color: AppColor.black87,
                              fontFamily: SharedManager.shared.fontFamilyName),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText('${S.current.mobileNo}', AppColor.black87,
                            15.0, FontWeight.w500, 1),
                        TextFormField(
                          controller: mobileController,
                          enabled: (this.isLoginwithSocialMedia == 'yes')
                              ? true
                              : false,
                          decoration: InputDecoration(hintText: 'number'),
                          style: TextStyle(
                              color: AppColor.black87,
                              fontFamily: SharedManager.shared.fontFamilyName),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText('${S.current.email}', AppColor.black87,
                            15.0, FontWeight.w500, 1),
                        TextFormField(
                          controller: emailController,
                          enabled: false,
                          decoration: InputDecoration(hintText: 'email'),
                          style: TextStyle(
                              color: AppColor.black87,
                              fontFamily: SharedManager.shared.fontFamilyName),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  InkWell(
                    onTap: () {
                      _updateProfile();
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: AppColor.themeColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: setCommonText('${S.current.update}',
                            AppColor.white, 17.0, FontWeight.w500, 1),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
