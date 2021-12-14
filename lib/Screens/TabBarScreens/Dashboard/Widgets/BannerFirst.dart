import 'package:flutter/material.dart';
import 'package:product/Helper/Constant.dart';

class BannerFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(AppImages.banner_one))),
    );
  }
}
