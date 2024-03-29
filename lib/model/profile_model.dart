class ProfileModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  ProfileModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    authStatus = json['authStatus'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['code'] = code;
    data['authStatus'] = authStatus;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Details? details;

  Data({this.details});

  Data.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic mobileNumber;
  dynamic pUserStatus;
  dynamic pUserAccountType;
  dynamic status;
  dynamic pUserPhoto;
  dynamic displayProfileImage;

  Details(
      {this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.pUserStatus,
      this.pUserAccountType,
      this.status,
      this.pUserPhoto,
      this.displayProfileImage});

  Details.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    email = json['email'] ?? '';
    mobileNumber = json['mobile_number'] ?? "";
    pUserStatus = json['p_user_status'];
    pUserAccountType = json['p_user_account_type'];
    status = json['status'];
    pUserPhoto = json['p_user_photo'];
    displayProfileImage = json['display_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['p_user_status'] = pUserStatus;
    data['p_user_account_type'] = pUserAccountType;
    data['status'] = status;
    data['p_user_photo'] = pUserPhoto;
    data['display_profile_image'] = displayProfileImage;
    return data;
  }
}
