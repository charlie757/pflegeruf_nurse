class LoginModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  LoginModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  dynamic token;
  UserDetails? userDetails;
  dynamic accountStatus;
  dynamic status;

  Data({this.token, this.userDetails, this.accountStatus});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userDetails = json['userDetails'] != null
        ? UserDetails.fromJson(json['userDetails'])
        : null;
    accountStatus = json['accountStatus'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    data['accountStatus'] = accountStatus;
    data['status'] = status;
    return data;
  }
}

class UserDetails {
  dynamic pUserId;
  dynamic pUserStatus;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic mobileNumber;
  dynamic userAccountType;
  dynamic displayProfileImage;

  UserDetails(
      {this.pUserId,
      this.pUserStatus,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.userAccountType,
      this.displayProfileImage});

  UserDetails.fromJson(Map<String, dynamic> json) {
    pUserId = json['p_user_id'];
    pUserStatus = json['p_user_status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    userAccountType = json['p_user_account_type'];
    displayProfileImage = json['display_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['p_user_id'] = pUserId;
    data['p_user_status'] = pUserStatus;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['p_user_account_type'] = userAccountType;
    data['display_profile_image'] = displayProfileImage;
    return data;
  }
}
