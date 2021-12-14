import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResUpdateProfile extends BaseModel {
  int code;
  String message;
  ProfileUserData userData;

  ResUpdateProfile({this.code, this.message, this.userData});

  ResUpdateProfile.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    userData = json['result'] != null
        ? new ProfileUserData.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.userData != null) {
      data['result'] = this.userData.toJson();
    }
    return data;
  }
}

class ProfileUserData {
  String userId;
  String name;
  String email;
  String profileImage;
  String phone;

  ProfileUserData(
      {this.userId, this.name, this.email, this.profileImage, this.phone});

  ProfileUserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['phone'] = this.phone;
    return data;
  }
}
