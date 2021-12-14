import 'package:flutter/material.dart';

//All Api placed in this class.
//Just replace with existing base url here.
class APIS {
  static var baseurl = "https://app.doobi.om/Webservices/";

  static var login = baseurl + "login";
  static var registration = baseurl + "registration";
  static var socialSignIn = baseurl + "social_signin";
  static var dashBoard = baseurl + "home";
  static var resDetails = baseurl + "details";
  static var addNewAddress = baseurl + "add_user_address";
  static var addressList = baseurl + "get_user_address";
  static var deleteAddress = baseurl + "delete_address";
  static var makeOrder = baseurl + "add_order";
  static var orderList = baseurl + "orders_list";
  static var orderDetails = baseurl + "order_details";
  static var allTopRestaurant = baseurl + "all_top_restaurants";
  static var mostPopularRestaurant = baseurl + "most_polupar_restaurants";
  static var profile = baseurl + "profile";
  static var mealDeals = baseurl + "mealDeal";
  static var searchKeyWords = baseurl + "search";
  static var notificationList = baseurl + "notifications";
  static var getToken = baseurl + "get_braintree_token";
  static var addRestaurantReview = baseurl + "add_restaurant_review";
  static var addDriverReview = baseurl + "add_driver_review";
  static var getOrderStatus = baseurl + "get_order_status";
  static var cancelOrder = baseurl + "cancel_order";
  static var getAllReview = baseurl + "get_all_review";
  static var walletAmount = baseurl + "get_wallet_amount/";
  static var getCategoryList = baseurl + "categories";
  static var changePassword = baseurl + "change_password";
  static var forgotPassword = baseurl + "forgot_password";
  static var checkPromocode = baseurl + "check_promocode";
  static var getDriverLocation = baseurl + "get_driver_location";
  static var verifyOTP = baseurl + "checkOtp";
  static var socialLogin = baseurl + "social_signin";
  static var updateProfile = baseurl + "updateProfile";
}

//We have used Shared preferance for storing some low level data.
//For this we have used this keys.
class DefaultKeys {
  static var userName = "name";
  static var userEmail = "email";
  static var userId = "userId";
  static var userImage = "image";
  static var userAddress = "address";
  static var userPhone = "phone";
  static var isLoggedIn = "isLoogedIn";
  static var pushToken = "firebaseToken";
}

//These are all required keys which are usefull for the Stripe,Paypal payment gateways as well as google place API.
//You must have to replaced with your new keys and API.
//Otherwise application will not work perfectly.
class Keys {
  //You must have to add paid google direcion api.Without paid direction api route will not work

  //Add Razor PayID
  static var razorPayId = 'rzp_test_XDtOe2jFxxxxxxx';
  //Add Google Direction API(You need to add biling address on google map console)
  static var directionAPI = "AIzaSyCEORGf8bOKBwHhh7L7gXqZe44qgkl3Ofw";
  // Add Paypal Merchant ID here
  static var paypalMerchantID = "9fjqbjhdxxxxxx";
  //Add Google MAP API(You need to add biling address on google map console)
  static var kGoogleApiKey = "AIzaSyCEORGf8bOKBwHhh7L7gXqZe44qgkl3Ofw";
  //Add you stripe publish key here.
  //For testing purpose please add test key. During deploymnet use the live key.
  static var publishKey = "pk_test_5MNsOgVhHdH1U3SMbBTzq7pxxxR";
}

//This is the app colors.
//You can change your theme color based on your requirements.
//This is the main application theme color.
class AppColor {
  //static var themeColor = Colors.green;
  static var pagingIndicatorColor = Colors.red;
  static var black = HexToColor("#000000");
  static var orangeDeep = Colors.deepOrange;
  static var colorGyay_100 = Colors.grey[100];
  static var white = Colors.white;
  static var amber = Colors.amber;
  static var grey = Colors.grey;
  static var black87 = Colors.black87;
  static var red = Colors.red;
  static var black38 = Colors.black38;
  static var deepOrange = Colors.deepOrange;
  static var black54 = Colors.black54;
  static var orange = Colors.orange;
  static var teal = Colors.teal;
  static var facebookBG = hexToColor("#5B7CB4"); //Facebook icon color
  static var googleBG = hexToColor("#D95946"); //Google plus icon color

  // You can use sample theme color

  static var themeColor = hexToColor('#063970');
  // static var themeColor = hexToColor('#2F3841'); //this is icon bg color.
  // static var themeColor = HexToColor("#79CABD");
  // static var themeColor = HexToColor("#f2bd68");
  // static var themeColor = HexToColor("#9468f2");
  // static var themeColor = HexToColor("#f268b4");
  // static var themeColor = HexToColor("#f26868");

}

//Convert color from hax color.
class HexToColor extends Color {
  static _hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }

  HexToColor(final String code) : super(_hexToColor(code));
}

//Important Images path we have used in application.
class AppImages {
  static var appLogo = "Assets/doobi.png";
  static var background = 'Assets/RestaurantDetails/RestaurantApp.jpg';
  static var googleIcon = "Assets/googlePlus.png";
  static var facebookIcon = "Assets/facebook.png";
  static var vegItem = "Assets/RestaurantDetails/veg.png";
  static var nonVegItem = "Assets/RestaurantDetails/nonVeg.png";
  static var cartDefaultImage = "Assets/Cart/emptyCart.png";

  /*Images for doobi M*/
  static const String profileBackgroundImage = "Assets/DoobiAssets/background_image.png";
  static const String splashScreen = "Assets/DoobiAssets/splash.jpeg";
  static const String loginImage = "Assets/DoobiAssets/login_image.png";
  static const String languageIcon = "Assets/DoobiAssets/language_icon.png";
  static const String locationIcon = "Assets/DoobiAssets/location_icon.png";
  static const String BackgroundImage = "Assets/DoobiAssets/laundry_background.png";
  static const String banner_one = "Assets/DoobiAssets/banner/banner_one.webp";
  static const String banner_two = "Assets/DoobiAssets/banner/banner_two.webp";
  static const String banner_three = "Assets/DoobiAssets/banner/banner_three.webp";


}

class AppRoute {
  static const dashboard = '/dashboard';
  static const tabbar = '/tabbar';
  static const login = '/login';
  static const signUp = '/signUp';
  static const checkOut = '/checkout';
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class Currency {
  //static const curr = '\$';
   static const curr = 'OMR';
  // static const curr = ''';
}
