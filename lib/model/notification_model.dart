class NotificationModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  List<Data>? data;

  NotificationModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    authStatus = json['authStatus'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['code'] = code;
    data['authStatus'] = authStatus;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic msg;
  dynamic notificationCreatedAt;
  dynamic bookingId;
  dynamic currentStatus;
  FromUser? fromUser;

  Data(
      {this.msg,
      this.notificationCreatedAt,
      this.bookingId,
      this.currentStatus,
      this.fromUser});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    notificationCreatedAt = json['notification_created_at'];
    bookingId = json['booking_id'];
    currentStatus = json['current_status'];
    fromUser =
        json['from_user'] != null ? FromUser.fromJson(json['from_user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = msg;
    data['notification_created_at'] = notificationCreatedAt;
    data['booking_id'] = bookingId;
    data['current_status'] = currentStatus;
    if (fromUser != null) {
      data['from_user'] = fromUser!.toJson();
    }
    return data;
  }
}

class FromUser {
  dynamic pUserId;
  dynamic pUserName;
  dynamic pUserSurname;
  dynamic displayProfileImage;
  dynamic ratingAsBuyer;

  FromUser(
      {this.pUserId,
      this.pUserName,
      this.pUserSurname,
      this.displayProfileImage,
      this.ratingAsBuyer});

  FromUser.fromJson(Map<String, dynamic> json) {
    pUserId = json['p_user_id'];
    pUserName = json['p_user_name'];
    pUserSurname = json['p_user_surname'];
    displayProfileImage = json['display_profile_image'];
    ratingAsBuyer = json['rating_as_buyer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['p_user_id'] = pUserId;
    data['p_user_name'] = pUserName;
    data['p_user_surname'] = pUserSurname;
    data['display_profile_image'] = displayProfileImage;
    data['rating_as_buyer'] = ratingAsBuyer;
    return data;
  }
}
