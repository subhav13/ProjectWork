import 'dart:io';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/CategoryListBLoC.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelCategoryList.dart';
import 'package:product/Screens/SubcategoryListScreen/SubcategoryListScreen.dart';
import 'package:product/generated/i18n.dart';
import 'package:progressive_image/progressive_image.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    try {} catch (ex) {
      print("banner dispose error");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    categoryListBloc.fetchAllCategoryList();
    return Scaffold(
      appBar: AppBar(
        title: setCommonText('${S.current.categories}', AppColor.white, 20.0,
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
      body: StreamBuilder(
          stream: categoryListBloc.categoryList,
          builder: (context, AsyncSnapshot<ResCategoryList> snapshot) {
            if (snapshot.hasData) {
              final categoryList = snapshot.data.categoryList;
              return Container(
                color: AppColor.grey[200],
                child: new GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 0.9,
                  children:
                      new List<Widget>.generate(categoryList.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SubcategoryListScreen(
                                  categoryID: categoryList[index].categoryId,
                                  categoryName:
                                      categoryList[index].categoryName,
                                )));
                      },
                      child: new GridTile(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 1.0, left: 1.0),
                          child: Container(
                              color: AppColor.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            spreadRadius: 1,
                                            offset: Offset(0, 1),
                                            color: AppColor.grey[400])
                                      ],
                                      // image: DecorationImage(
                                      //   fit: BoxFit.cover,
                                      //   image: NetworkImage(
                                      //       categoryList[index].image),
                                      // )
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: ProgressiveImage(
                                        placeholder:
                                            AssetImage('Assets/loading.gif'),
                                        // size: 1.87KB
                                        thumbnail:
                                            AssetImage('Assets/loading.gif'),
                                        // size: 1.29MB
                                        image: AssetImage(
                                            AppImages.BackgroundImage),
                                        //Todo : NetworkImage -> [categoryList[index].image]
                                        height: 70,
                                        width: 70,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        setCommonText(
                                            categoryList[index].categoryName,
                                            AppColor.black87,
                                            14.0,
                                            FontWeight.w500,
                                            1),
                                        setCommonText(
                                            '${categoryList[index].totalCount} ${S.current.items}',
                                            AppColor.grey[500],
                                            12.0,
                                            FontWeight.w500,
                                            1)
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  }),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
