import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/RestaurantDetails.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/Screens/Cart/Cart.dart';
import 'package:product/Screens/ReviewListScreen/ReviewListScreen.dart';
import 'package:product/generated/i18n.dart';
import 'package:share/share.dart';
import 'Widgets/ReviewWidgets/ReviewWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new BannerDetailsScreen());

class BannerDetailsScreen extends StatefulWidget {
  final restaurantID;
  BannerDetailsScreen({Key key, this.restaurantID}) : super(key: key);
  @override
  _BannerDetailsScreenState createState() => _BannerDetailsScreenState();
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
  var itemCount = 0;
  var totlaPrice = 0.0;
  bool isFirst = false;
  var result = ResDetails();
  bool isGrid = false;

  @override
  void initState() {
    // try {
    //   SharedManager.shared.myBanner.dispose();
    //   SharedManager.shared.myBanner = null;
    // } catch (ex) {
    //   print("banner dispose error");
    // }
    super.initState();
    print("Restaurant id:${widget.restaurantID}");
    SharedManager.shared.restaurantID = this.widget.restaurantID;
  }

  @override
  void dispose() {
    try {} catch (ex) {
      print("banner dispose error");
    }
    super.dispose();
  }

  _launchCaller() async {
    final url = "tel://${this.result.phone}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _setSocialWidgets(double width, String review, String resName) {
    return new Container(
      width: width,
      height: 80,
      color: AppColor.white,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            onTap: () {
              //you can add any thing here for shaing
              Share.share(
                '$resName , ${SharedManager.shared.resAddress}',
              );
            },
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.share, color: AppColor.black, size: 20),
                setCommonText(
                    S.current.share, AppColor.black, 14.0, FontWeight.w500, 1)
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () {
              _launchCaller();
            },
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.phone, color: AppColor.black, size: 20),
                setCommonText(
                    S.current.contact, AppColor.black, 14.0, FontWeight.w500, 1)
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () {
              if (review != '0.0') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReviewListScreen(
                        restaurantId: this.widget.restaurantID,
                        restaurantName: resName),
                    fullscreenDialog: true));
              } else {
                SharedManager.shared.showAlertDialog(
                    '${S.current.reviewNotAvailable}', context);
              }
            },
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    setCommonText(
                        '$review', AppColor.black, 16.0, FontWeight.bold, 1),
                    Icon(
                      Icons.star,
                      color: AppColor.orange,
                      size: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                setCommonText("${S.current.reviews}", AppColor.black, 13.0,
                    FontWeight.w500, 1)
              ],
            ),
          )
        ],
      ),
    );
  }

  _setRestaurantDetails(List<Categories> categories) {
    return new Container(
        // color:AppColor.red,
        padding: new EdgeInsets.only(left: 15, right: 15, top: 5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            setCommonText(S.current.res_recommenditions, AppColor.black, 16.0,
                FontWeight.w500, 1),
            SizedBox(
              height: 5,
            ),
            new Wrap(
                spacing: 5,
                runSpacing: 0,
                alignment: WrapAlignment.start,
                children: _setChipsWidgets(categories)),
            Divider(
              color: AppColor.grey,
            ),
          ],
        ));
  }

  List<Chip> _setChipsWidgets(List<Categories> categories) {
    List<Chip> chips = [];
    for (int i = 0; i < categories.length; i++) {
      final chip = new Chip(
        backgroundColor: AppColor.themeColor,
        label: setCommonText('${categories[i].categoryName}', AppColor.white,
            12.0, FontWeight.w500, 1),
      );
      chips.add(chip);
    }
    return chips;
  }

  _setAddressWidgets(
      String address, String discount, String openingTime, String closingTime) {
    return new Container(
      // height: 155,
      color: AppColor.white,
      padding: new EdgeInsets.only(top: 3, left: 15, right: 15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          setCommonText(
              S.current.res_address, AppColor.black, 16.0, FontWeight.w500, 1),
          SizedBox(height: 3),
          new Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: new Container(
                    // color: AppColor.white,
                    // height: 50,
                    child: setCommonText(
                        address, AppColor.black, 12.0, FontWeight.w400, 2)),
              ),
            ],
          ),
          new Divider(
            color: AppColor.grey,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              setCommonText(S.current.delivery_in_minutes, AppColor.amber, 15.0,
                  FontWeight.w500, 2),
              SizedBox(
                height: 5,
              ),
              setCommonText('$discount% ${S.current.all_offer}', AppColor.teal,
                  13.0, FontWeight.w500, 1),
            ],
          ),
          Divider(
            color: AppColor.grey,
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(S.current.opening_time, AppColor.amber, 14.0,
                      FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText('$openingTime AM', AppColor.teal, 12.0,
                      FontWeight.w500, 1),
                ],
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(S.current.closing_time, AppColor.amber, 14.0,
                      FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText('$closingTime PM', AppColor.teal, 12.0,
                      FontWeight.w500, 1),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText('${S.current.availability}', AppColor.black,
                      14.0, FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  (result.isAvailable == '1')
                      ? setCommonText('${S.current.open}', Colors.green, 12.0,
                          FontWeight.bold, 1)
                      : setCommonText('${S.current.closed}', AppColor.red, 12.0,
                          FontWeight.bold, 1),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: AppColor.grey,
          )
        ],
      ),
    );
  }

  List<Subcategories> subcatList = [];

  _setDynamicCategory(int subCatCount, dynamic data, double width) {
    return Container(
      height: calculateTotalHeight(data),
      // color: AppColor.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: new ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: subcatList.length,
          // itemCount: 2,
          itemBuilder: (context, row) {
            return Container(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: AppColor.grey[300],
                          offset: Offset(0, 0))
                    ]),
                child: new Row(
                  children: <Widget>[
                    new Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(subcatList[row].image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Expanded(
                      flex: 2,
                      child: new Container(
                        // color: AppColor.red,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                    flex: 2,
                                    child: setCommonText(
                                        subcatList[row].name,
                                        AppColor.black,
                                        14.0,
                                        FontWeight.w500,
                                        1)),
                                // SizedBox(width: 5,),
                              ],
                            ),
                            setCommonText(subcatList[row].catigoryName,
                                AppColor.black54, 13.0, FontWeight.w500, 1),
                            SizedBox(
                              height: 2,
                            ),
                            setCommonText(subcatList[row].description,
                                AppColor.grey[600], 12.0, FontWeight.w400, 2),
                            SizedBox(
                              height: 5,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    new Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        setCommonText(
                                            '${Currency.curr}${subcatList[row].price}',
                                            AppColor.grey[600],
                                            12.0,
                                            FontWeight.w600,
                                            1),
                                        new Container(
                                          height: 2,
                                          width: 40,
                                          color: AppColor.grey[700],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    setCommonText(
                                        '${Currency.curr}${double.parse(subcatList[row].price) - double.parse(subcatList[row].discount)}',
                                        AppColor.black,
                                        12.0,
                                        FontWeight.w700,
                                        1),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: new Container(
                                    height: 30,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: InkWell(
                                      onTap: () {
                                        if (subcatList[row].isAvailable ==
                                            '1') {
                                          setState(() {
                                            if (subcatList[row].isAdded) {
                                              subcatList[row].isAdded = false;
                                            } else {
                                              subcatList[row].isAdded = true;
                                            }
                                            this.itemCount =
                                                _setItemCount(subcatList);
                                          });
                                        } else {
                                          commonItemOutofStockAlert(context);
                                        }
                                      },
                                      child: new Center(
                                        child: subcatList[row].isAdded
                                            ? setCommonText(
                                                S.current.added,
                                                AppColor.red,
                                                12.0,
                                                FontWeight.w600,
                                                1)
                                            : setCommonText(
                                                S.current.add_plus,
                                                AppColor.themeColor,
                                                12.0,
                                                FontWeight.w600,
                                                1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double calculateTotalHeight(List<Categories> categories) {
    var height = 0.0;
    var count = 0.0;
    this.subcatList = [];
    for (var category in categories) {
      count = count + category.subcategories.length;
      for (var subCat in category.subcategories) {
        subCat.catigoryName = category.categoryName;
        this.subcatList.add(subCat);
      }
    }
    height = count * 115;
    print("Final Height is:$height");
    return height;
  }

  int _setItemCount(List<Subcategories> subcategoryList) {
    var count = 0;
    var price = 0.0;
    SharedManager.shared.cartItems = [];

    for (int j = 0; j < subcategoryList.length; j++) {
      if (subcategoryList[j].isAdded) {
        count = count + 1;
        price = price +
            (double.parse(subcategoryList[j].price) -
                double.parse(subcategoryList[j].discount));
        SharedManager.shared.cartItems.add(subcategoryList[j]);
      }
    }
    this.totlaPrice = price;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    resDetailsBloc.fetchRestaurantDetails(widget.restaurantID, APIS.resDetails);

    _setHeroImage(String strUrl) {
      return new Stack(
        children: <Widget>[
          new DecoratedBox(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(strUrl),
                // image: new AssetImage('Assets/RestaurantDetails/RestaurantApp.jpg'),
              ),
              shape: BoxShape.rectangle,
            ),
          ),
        ],
      );
    }

    return new Scaffold(
      body: new StreamBuilder(
        stream: resDetailsBloc.restaurantDetails,
        builder: (context, AsyncSnapshot<ResRestaurantDetails> snapshot) {
          if (snapshot.hasData) {
            if (!isFirst) {
              this.isFirst = true;
              this.result = snapshot.data.result;
              SharedManager.shared.resLatitude = this.result.latitude;
              SharedManager.shared.resLongitude = this.result.longitude;
              SharedManager.shared.resAddress = this.result.address;
              SharedManager.shared.resImage = this.result.bannerImage;
              SharedManager.shared.resName = this.result.name;
            } else {
//
            }
            // var result = snapshot.data.result;
            print("Restaurant final result:$result");
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  backgroundColor: AppColor.themeColor,
                  iconTheme: IconThemeData(color: AppColor.white),
                  expandedHeight: MediaQuery.of(context).size.width - 120,
                  elevation: 0.1,
                  pinned: true,
                  flexibleSpace: new FlexibleSpaceBar(
                    centerTitle: true,
                    title: setCommonText(
                        result.name, AppColor.white, 14.0, FontWeight.w500, 2),
                    background: new Stack(
                      children: <Widget>[
                        _setHeroImage(result.bannerImage),
                        Container(
                          color: AppColor.black.withOpacity(0.3),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: new EdgeInsets.all(8),
                    child: new Container(
                      color: AppColor.white,
                      child: new Column(
                        children: <Widget>[
                          _setSocialWidgets(
                              width,
                              (result.avgReview != null)
                                  ? result.avgReview
                                  : '0.0',
                              result.name),
                          _setRestaurantDetails(result.categories),
                          _setAddressWidgets(result.address, result.discount,
                              result.openingTime, result.closingTime),
                          _setDynamicCategory(
                            result.categories.length,
                            result.categories,
                            width,
                          ),
                          ReviewWidgets(result.reviews,
                              this.widget.restaurantID, result.name),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10.0),
          child: (this.itemCount > 0)
              ? new Container(
                  color: AppColor.white,
                  height: 50,
                  child: new Material(
                      color: AppColor.themeColor,
                      borderRadius: new BorderRadius.circular(30),
                      child: new Container(
                        padding: new EdgeInsets.only(left: 20, right: 15),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "${this.itemCount} ${S.current.items}",
                                  style: new TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                new Text(
                                  "${S.current.totals} ${Currency.curr}${this.totlaPrice}",
                                  style: new TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () {
                                    if (result.isAvailable == '1') {
                                      List<Subcategories> listData = [];
                                      for (int i = 0;
                                          i < this.result.categories.length;
                                          i++) {
                                        List<Subcategories> subList = this
                                            .result
                                            .categories[i]
                                            .subcategories;
                                        for (int j = 0;
                                            j < subList.length;
                                            j++) {
                                          if (subList[j].isAdded) {
                                            listData.add(subList[j]);
                                          }
                                        }
                                      }
                                      SharedManager.shared.cartItems = listData;
                                      SharedManager.shared.resAddress =
                                          this.result.address;
                                      SharedManager.shared.resImage =
                                          this.result.bannerImage;
                                      SharedManager.shared.resName =
                                          this.result.name;
                                      SharedManager.shared.isFromTab = false;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => CartApp()));
                                    } else {
                                      commonRestaurantCloseAlert(context);
                                    }
                                  },
                                  child: new Text(
                                    S.current.view_cart,
                                    style: new TextStyle(
                                        fontSize: 16,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                new Icon(Icons.arrow_forward,
                                    color: AppColor.white)
                              ],
                            )
                          ],
                        ),
                      )),
                )
              : null),
    );
  }
}
