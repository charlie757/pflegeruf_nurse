class ReviewModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  ReviewModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    authStatus = json['authStatus'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  List<Ratings>? ratings;

  Data({this.ratings});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ratings {
  int? ratingId;
  String? ratingType;
  int? ratingByUserId;
  int? ratingToUserId;
  int? ratingStar;
  String? ratingDesc;
  String? ratingCreatedAt;
  String? ratingUpdatedAt;
  int? ratingProductId;
  ByPatient? byPatient;
  Product? product;

  Ratings(
      {this.ratingId,
      this.ratingType,
      this.ratingByUserId,
      this.ratingToUserId,
      this.ratingStar,
      this.ratingDesc,
      this.ratingCreatedAt,
      this.ratingUpdatedAt,
      this.ratingProductId,
      this.byPatient,
      this.product});

  Ratings.fromJson(Map<String, dynamic> json) {
    ratingId = json['rating_id'];
    ratingType = json['rating_type'];
    ratingByUserId = json['rating_by_user_id'];
    ratingToUserId = json['rating_to_user_id'];
    ratingStar = json['rating_star'];
    ratingDesc = json['rating_desc'];
    ratingCreatedAt = json['rating_created_at'];
    ratingUpdatedAt = json['rating_updated_at'];
    ratingProductId = json['rating_product_id'];
    byPatient = json['by_patient'] != null
        ? new ByPatient.fromJson(json['by_patient'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rating_id'] = ratingId;
    data['rating_type'] = ratingType;
    data['rating_by_user_id'] = ratingByUserId;
    data['rating_to_user_id'] = ratingToUserId;
    data['rating_star'] = ratingStar;
    data['rating_desc'] = ratingDesc;
    data['rating_created_at'] = ratingCreatedAt;
    data['rating_updated_at'] = ratingUpdatedAt;
    data['rating_product_id'] = ratingProductId;
    if (this.byPatient != null) {
      data['by_patient'] = this.byPatient!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class ByPatient {
  dynamic displayProfileImage;
  dynamic pUserName;
  dynamic pUserUsername;
  dynamic pUserSurname;

  ByPatient({
    this.displayProfileImage,
    this.pUserName,
    this.pUserUsername,
    this.pUserSurname,
  });

  ByPatient.fromJson(Map<String, dynamic> json) {
    pUserName = json['p_user_name'];
    pUserUsername = json['p_user_username'];
    pUserSurname = json['p_user_surname'];

    displayProfileImage = json['display_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_user_name'] = pUserName;
    data['p_user_username'] = pUserUsername;
    data['p_user_surname'] = pUserSurname;
    data['display_profile_image'] = displayProfileImage;
    return data;
  }
}

class Product {
  dynamic productTitle;

  Product({
    this.productTitle,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productTitle = json['product_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_title'] = productTitle;
    return data;
  }
}
