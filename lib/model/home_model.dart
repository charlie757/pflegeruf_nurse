class HomeModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  HomeModel({this.status, this.code, this.authStatus, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  UserDetails? userDetails;
  List<Banners>? banners;
  List<Category>? category;
  String? bannerPath;
  String? profilePath;
  String? categoryPath;

  Data(
      {this.userDetails,
      this.banners,
      this.category,
      this.bannerPath,
      this.profilePath,
      this.categoryPath});

  Data.fromJson(Map<String, dynamic> json) {
    userDetails = json['userDetails'] != null
        ? UserDetails.fromJson(json['userDetails'])
        : null;
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    bannerPath = json['BannerPath'];
    profilePath = json['ProfilePath'];
    categoryPath = json['CategoryPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    data['BannerPath'] = bannerPath;
    data['ProfilePath'] = profilePath;
    data['CategoryPath'] = categoryPath;
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
  dynamic pUserAccountType;
  dynamic pUserPhoto;
  dynamic displayProfileImage;

  UserDetails(
      {this.pUserId,
      this.pUserStatus,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.pUserAccountType,
      this.pUserPhoto,
      this.displayProfileImage});

  UserDetails.fromJson(Map<String, dynamic> json) {
    pUserId = json['p_user_id'];
    pUserStatus = json['p_user_status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    pUserAccountType = json['p_user_account_type'];
    pUserPhoto = json['p_user_photo'];
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
    data['p_user_account_type'] = pUserAccountType;
    data['p_user_photo'] = pUserPhoto;
    data['display_profile_image'] = displayProfileImage;
    return data;
  }
}

class Banners {
  dynamic bannerId;
  dynamic name;
  dynamic subtitle;
  dynamic nameDe;
  dynamic subtitleDe;
  dynamic nameEs;
  dynamic subtitleEs;
  dynamic bannerImage;
  dynamic bannerStatus;
  dynamic bannerCreatedAt;
  dynamic bannerUpdatedAt;

  Banners(
      {this.bannerId,
      this.name,
      this.subtitle,
      this.nameDe,
      this.subtitleDe,
      this.nameEs,
      this.subtitleEs,
      this.bannerImage,
      this.bannerStatus,
      this.bannerCreatedAt,
      this.bannerUpdatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    name = json['name'];
    subtitle = json['subtitle'];
    nameDe = json['name_de'];
    subtitleDe = json['subtitle_de'];
    nameEs = json['name_es'];
    subtitleEs = json['subtitle_es'];
    bannerImage = json['banner_image'];
    bannerStatus = json['banner_status'];
    bannerCreatedAt = json['banner_created_at'];
    bannerUpdatedAt = json['banner_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['banner_id'] = bannerId;
    data['name'] = name;
    data['subtitle'] = subtitle;
    data['name_de'] = nameDe;
    data['subtitle_de'] = subtitleDe;
    data['name_es'] = nameEs;
    data['subtitle_es'] = subtitleEs;
    data['banner_image'] = bannerImage;
    data['banner_status'] = bannerStatus;
    data['banner_created_at'] = bannerCreatedAt;
    data['banner_updated_at'] = bannerUpdatedAt;
    return data;
  }
}

class Category {
  dynamic categoryId;
  dynamic categoryNameDe;
  dynamic categoryImage;
  dynamic categoryStatus;
  dynamic categoryDisplayHome;
  dynamic categoryCreatedAt;
  dynamic categoryUpdatedAt;
  dynamic categorySorting;
  dynamic categoryNameEs;
  dynamic categoryName;

  Category(
      {this.categoryId,
      this.categoryNameDe,
      this.categoryImage,
      this.categoryStatus,
      this.categoryDisplayHome,
      this.categoryCreatedAt,
      this.categoryUpdatedAt,
      this.categorySorting,
      this.categoryNameEs,
      this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryNameDe = json['category_name_de'];
    categoryImage = json['category_image'];
    categoryStatus = json['category_status'];
    categoryDisplayHome = json['category_display_home'];
    categoryCreatedAt = json['category_created_at'];
    categoryUpdatedAt = json['category_updated_at'];
    categorySorting = json['category_sorting'];
    categoryNameEs = json['category_name_es'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category_id'] = categoryId;
    data['category_name_de'] = categoryNameDe;
    data['category_image'] = categoryImage;
    data['category_status'] = categoryStatus;
    data['category_display_home'] = categoryDisplayHome;
    data['category_created_at'] = categoryCreatedAt;
    data['category_updated_at'] = categoryUpdatedAt;
    data['category_sorting'] = categorySorting;
    data['category_name_es'] = categoryNameEs;
    data['category_name'] = categoryName;
    return data;
  }
}
