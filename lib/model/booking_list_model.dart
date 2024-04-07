class BookingListModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  BookingListModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    authStatus = json['authStatus'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['code'] = code;
    data['authStatus'] = authStatus;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<MyListing>? myListing;

  Data({this.myListing});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['myListing'] != null) {
      myListing = <MyListing>[];
      json['myListing'].forEach((v) {
        myListing!.add(MyListing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (myListing != null) {
      data['myListing'] = myListing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyListing {
  dynamic productId;
  dynamic productBookingNumber;
  dynamic productUserId;
  dynamic productNurseId;
  dynamic productTitle;
  dynamic productSubcategory;
  dynamic productPrice;
  dynamic productDetails;
  dynamic productImage;
  dynamic productSlides;
  dynamic productStatus;
  dynamic productDisplayHome;
  dynamic productCreatedAt;
  dynamic productUpdatedAt;
  dynamic productViews;
  dynamic productWinUserId;
  dynamic productWinDatetime;
  dynamic bookingMessage;
  dynamic statusId;
  dynamic patientId;
  dynamic nurseId;
  dynamic bookingId;
  dynamic status;
  dynamic statusCreatedAt;
  dynamic statusUpdatedAt;
  Category? category;
  User? user;
  Nurse? nurse;

  MyListing(
      {this.productId,
      this.productBookingNumber,
      this.productUserId,
      this.productNurseId,
      this.productTitle,
      this.productSubcategory,
      this.productPrice,
      this.productDetails,
      this.productImage,
      this.productSlides,
      this.productStatus,
      this.productDisplayHome,
      this.productCreatedAt,
      this.productUpdatedAt,
      this.productViews,
      this.productWinUserId,
      this.productWinDatetime,
      this.bookingMessage,
      this.statusId,
      this.patientId,
      this.nurseId,
      this.bookingId,
      this.status,
      this.statusCreatedAt,
      this.statusUpdatedAt,
      this.category,
      this.user,
      this.nurse});

  MyListing.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productBookingNumber = json['product_booking_number'];
    productUserId = json['product_user_id'];
    productNurseId = json['product_nurse_id'];
    productTitle = json['product_title'];
    productSubcategory = json['product_subcategory'];
    productPrice = json['product_price'];
    productDetails = json['product_details'];
    productImage = json['product_image'];
    productSlides = json['product_slides'];
    productStatus = json['product_status'];
    productDisplayHome = json['product_display_home'];
    productCreatedAt = json['product_created_at'];
    productUpdatedAt = json['product_updated_at'];
    productViews = json['product_views'];
    productWinUserId = json['product_win_user_id'];
    productWinDatetime = json['product_win_datetime'];
    bookingMessage = json['booking_message'];
    statusId = json['status_id'];
    patientId = json['patient_id'];
    nurseId = json['nurse_id'];
    bookingId = json['booking_id'];
    status = json['status'];
    statusCreatedAt = json['status_created_at'];
    statusUpdatedAt = json['status_updated_at'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    nurse = json['nurse'] != null ? Nurse.fromJson(json['nurse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = productId;
    data['product_booking_number'] = productBookingNumber;
    data['product_user_id'] = productUserId;
    data['product_nurse_id'] = productNurseId;
    data['product_title'] = productTitle;
    data['product_subcategory'] = productSubcategory;
    data['product_price'] = productPrice;
    data['product_details'] = productDetails;
    data['product_image'] = productImage;
    data['product_slides'] = productSlides;
    data['product_status'] = productStatus;
    data['product_display_home'] = productDisplayHome;
    data['product_created_at'] = productCreatedAt;
    data['product_updated_at'] = productUpdatedAt;
    data['product_views'] = productViews;
    data['product_win_user_id'] = productWinUserId;
    data['product_win_datetime'] = productWinDatetime;
    data['booking_message'] = bookingMessage;
    data['status_id'] = statusId;
    data['patient_id'] = patientId;
    data['nurse_id'] = nurseId;
    data['booking_id'] = bookingId;
    data['status'] = status;
    data['status_created_at'] = statusCreatedAt;
    data['status_updated_at'] = statusUpdatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (nurse != null) {
      data['nurse'] = nurse!.toJson();
    }
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
  dynamic description;
  dynamic descriptionDe;

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
      this.categoryName,
      this.description,
      this.descriptionDe});

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
    description = json['description'];
    descriptionDe = json['description_de'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['description'] = description;
    data['description_de'] = descriptionDe;
    return data;
  }
}

class User {
  dynamic pUserId;
  dynamic pUserName;
  dynamic pUserUsername;
  dynamic pUserSurname;
  dynamic pUserSalutation;
  dynamic pUserMobileCountry;
  dynamic pUserMobile;
  dynamic pUserEmail;
  dynamic pUserStatus;
  dynamic pUserCreatedOn;
  dynamic pUserLastlogin;
  dynamic pUserPhoto;
  dynamic pUserAccountType;
  dynamic pUserAddress;
  double? pUserLat;
  double? pUserLon;
  dynamic pUserAddressNo;
  dynamic pUserAddressPostal;
  dynamic pUserAddressLocation;
  dynamic pUserAddressStreet;
  dynamic pUserCompanyName;
  dynamic pUserTaxNumber;
  dynamic pUserTelegram;
  dynamic pUserBillingAddress;
  dynamic pUserBillingNo;
  dynamic pUserBillingPostal;
  dynamic pUserBillingLocation;
  dynamic pUserLang;
  dynamic pUserTotalOnlineAd;
  dynamic pUserTotalBought;
  dynamic pUserTotalSold;
  dynamic pUserActivePackage;
  dynamic pUserBio;
  dynamic pUserStripeCustomerId;
  dynamic displayProfileImage;
  dynamic ratingAsBuyer;

  User(
      {this.pUserId,
      this.pUserName,
      this.pUserUsername,
      this.pUserSurname,
      this.pUserSalutation,
      this.pUserMobileCountry,
      this.pUserMobile,
      this.pUserEmail,
      this.pUserStatus,
      this.pUserCreatedOn,
      this.pUserLastlogin,
      this.pUserPhoto,
      this.pUserAccountType,
      this.pUserAddress,
      this.pUserLat,
      this.pUserLon,
      this.pUserAddressNo,
      this.pUserAddressPostal,
      this.pUserAddressLocation,
      this.pUserAddressStreet,
      this.pUserCompanyName,
      this.pUserTaxNumber,
      this.pUserTelegram,
      this.pUserBillingAddress,
      this.pUserBillingNo,
      this.pUserBillingPostal,
      this.pUserBillingLocation,
      this.pUserLang,
      this.pUserTotalOnlineAd,
      this.pUserTotalBought,
      this.pUserTotalSold,
      this.pUserActivePackage,
      this.pUserBio,
      this.pUserStripeCustomerId,
      this.displayProfileImage,
      this.ratingAsBuyer});

  User.fromJson(Map<String, dynamic> json) {
    pUserId = json['p_user_id'];
    pUserName = json['p_user_name'];
    pUserUsername = json['p_user_username'];
    pUserSurname = json['p_user_surname'];
    pUserSalutation = json['p_user_salutation'];
    pUserMobileCountry = json['p_user_mobile_country'];
    pUserMobile = json['p_user_mobile'];
    pUserEmail = json['p_user_email'];
    pUserStatus = json['p_user_status'];
    pUserCreatedOn = json['p_user_created_on'];
    pUserLastlogin = json['p_user_lastlogin'];
    pUserPhoto = json['p_user_photo'];
    pUserAccountType = json['p_user_account_type'];
    pUserAddress = json['p_user_address'];
    pUserLat = json['p_user_lat'];
    pUserLon = json['p_user_lon'];
    pUserAddressNo = json['p_user_address_no'];
    pUserAddressPostal = json['p_user_address_postal'];
    pUserAddressLocation = json['p_user_address_location'];
    pUserAddressStreet = json['p_user_address_street'];
    pUserCompanyName = json['p_user_company_name'];
    pUserTaxNumber = json['p_user_tax_number'];
    pUserTelegram = json['p_user_telegram'];
    pUserBillingAddress = json['p_user_billing_address'];
    pUserBillingNo = json['p_user_billing_no'];
    pUserBillingPostal = json['p_user_billing_postal'];
    pUserBillingLocation = json['p_user_billing_location'];
    pUserLang = json['p_user_lang'];
    pUserTotalOnlineAd = json['p_user_total_online_ad'];
    pUserTotalBought = json['p_user_total_bought'];
    pUserTotalSold = json['p_user_total_sold'];
    pUserActivePackage = json['p_user_active_package'];
    pUserBio = json['p_user_bio'];
    pUserStripeCustomerId = json['p_user_stripe_customer_id'];
    displayProfileImage = json['display_profile_image'];
    ratingAsBuyer = json['rating_as_buyer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['p_user_id'] = pUserId;
    data['p_user_name'] = pUserName;
    data['p_user_username'] = pUserUsername;
    data['p_user_surname'] = pUserSurname;
    data['p_user_salutation'] = pUserSalutation;
    data['p_user_mobile_country'] = pUserMobileCountry;
    data['p_user_mobile'] = pUserMobile;
    data['p_user_email'] = pUserEmail;
    data['p_user_status'] = pUserStatus;
    data['p_user_created_on'] = pUserCreatedOn;
    data['p_user_lastlogin'] = pUserLastlogin;
    data['p_user_photo'] = pUserPhoto;
    data['p_user_account_type'] = pUserAccountType;
    data['p_user_address'] = pUserAddress;
    data['p_user_lat'] = pUserLat;
    data['p_user_lon'] = pUserLon;
    data['p_user_address_no'] = pUserAddressNo;
    data['p_user_address_postal'] = pUserAddressPostal;
    data['p_user_address_location'] = pUserAddressLocation;
    data['p_user_address_street'] = pUserAddressStreet;
    data['p_user_company_name'] = pUserCompanyName;
    data['p_user_tax_number'] = pUserTaxNumber;
    data['p_user_telegram'] = pUserTelegram;
    data['p_user_billing_address'] = pUserBillingAddress;
    data['p_user_billing_no'] = pUserBillingNo;
    data['p_user_billing_postal'] = pUserBillingPostal;
    data['p_user_billing_location'] = pUserBillingLocation;
    data['p_user_lang'] = pUserLang;
    data['p_user_total_online_ad'] = pUserTotalOnlineAd;
    data['p_user_total_bought'] = pUserTotalBought;
    data['p_user_total_sold'] = pUserTotalSold;
    data['p_user_active_package'] = pUserActivePackage;
    data['p_user_bio'] = pUserBio;
    data['p_user_stripe_customer_id'] = pUserStripeCustomerId;
    data['display_profile_image'] = displayProfileImage;
    data['rating_as_buyer'] = ratingAsBuyer;
    return data;
  }
}

class Nurse {
  dynamic pUserId;
  dynamic pUserName;
  dynamic pUserUsername;
  dynamic pUserSurname;
  dynamic pUserSalutation;
  dynamic pUserMobileCountry;
  dynamic pUserMobile;
  dynamic pUserEmail;
  dynamic pUserStatus;
  dynamic pUserCreatedOn;
  dynamic pUserLastlogin;
  dynamic pUserPhoto;
  dynamic pUserAccountType;
  dynamic pUserAddress;
  double? pUserLat;
  dynamic pUserLon;
  dynamic pUserAddressNo;
  dynamic pUserAddressPostal;
  dynamic pUserAddressLocation;
  dynamic pUserAddressStreet;
  dynamic pUserCompanyName;
  dynamic pUserTaxNumber;
  dynamic pUserTelegram;
  dynamic pUserBillingAddress;
  dynamic pUserBillingNo;
  dynamic pUserBillingPostal;
  dynamic pUserBillingLocation;
  dynamic pUserLang;
  dynamic pUserTotalOnlineAd;
  dynamic pUserTotalBought;
  dynamic pUserTotalSold;
  dynamic pUserActivePackage;
  dynamic pUserBio;
  dynamic pUserStripeCustomerId;
  dynamic displayProfileImage;
  dynamic ratingAsBuyer;

  Nurse(
      {this.pUserId,
      this.pUserName,
      this.pUserUsername,
      this.pUserSurname,
      this.pUserSalutation,
      this.pUserMobileCountry,
      this.pUserMobile,
      this.pUserEmail,
      this.pUserStatus,
      this.pUserCreatedOn,
      this.pUserLastlogin,
      this.pUserPhoto,
      this.pUserAccountType,
      this.pUserAddress,
      this.pUserLat,
      this.pUserLon,
      this.pUserAddressNo,
      this.pUserAddressPostal,
      this.pUserAddressLocation,
      this.pUserAddressStreet,
      this.pUserCompanyName,
      this.pUserTaxNumber,
      this.pUserTelegram,
      this.pUserBillingAddress,
      this.pUserBillingNo,
      this.pUserBillingPostal,
      this.pUserBillingLocation,
      this.pUserLang,
      this.pUserTotalOnlineAd,
      this.pUserTotalBought,
      this.pUserTotalSold,
      this.pUserActivePackage,
      this.pUserBio,
      this.pUserStripeCustomerId,
      this.displayProfileImage,
      this.ratingAsBuyer});

  Nurse.fromJson(Map<String, dynamic> json) {
    pUserId = json['p_user_id'];
    pUserName = json['p_user_name'];
    pUserUsername = json['p_user_username'];
    pUserSurname = json['p_user_surname'];
    pUserSalutation = json['p_user_salutation'];
    pUserMobileCountry = json['p_user_mobile_country'];
    pUserMobile = json['p_user_mobile'];
    pUserEmail = json['p_user_email'];
    pUserStatus = json['p_user_status'];
    pUserCreatedOn = json['p_user_created_on'];
    pUserLastlogin = json['p_user_lastlogin'];
    pUserPhoto = json['p_user_photo'];
    pUserAccountType = json['p_user_account_type'];
    pUserAddress = json['p_user_address'];
    pUserLat = json['p_user_lat'];
    pUserLon = json['p_user_lon'];
    pUserAddressNo = json['p_user_address_no'];
    pUserAddressPostal = json['p_user_address_postal'];
    pUserAddressLocation = json['p_user_address_location'];
    pUserAddressStreet = json['p_user_address_street'];
    pUserCompanyName = json['p_user_company_name'];
    pUserTaxNumber = json['p_user_tax_number'];
    pUserTelegram = json['p_user_telegram'];
    pUserBillingAddress = json['p_user_billing_address'];
    pUserBillingNo = json['p_user_billing_no'];
    pUserBillingPostal = json['p_user_billing_postal'];
    pUserBillingLocation = json['p_user_billing_location'];
    pUserLang = json['p_user_lang'];
    pUserTotalOnlineAd = json['p_user_total_online_ad'];
    pUserTotalBought = json['p_user_total_bought'];
    pUserTotalSold = json['p_user_total_sold'];
    pUserActivePackage = json['p_user_active_package'];
    pUserBio = json['p_user_bio'];
    pUserStripeCustomerId = json['p_user_stripe_customer_id'];
    displayProfileImage = json['display_profile_image'];
    ratingAsBuyer = json['rating_as_buyer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_user_id'] = this.pUserId;
    data['p_user_name'] = this.pUserName;
    data['p_user_username'] = this.pUserUsername;
    data['p_user_surname'] = this.pUserSurname;
    data['p_user_salutation'] = this.pUserSalutation;
    data['p_user_mobile_country'] = this.pUserMobileCountry;
    data['p_user_mobile'] = this.pUserMobile;
    data['p_user_email'] = this.pUserEmail;
    data['p_user_status'] = this.pUserStatus;
    data['p_user_created_on'] = this.pUserCreatedOn;
    data['p_user_lastlogin'] = this.pUserLastlogin;
    data['p_user_photo'] = this.pUserPhoto;
    data['p_user_account_type'] = this.pUserAccountType;
    data['p_user_address'] = this.pUserAddress;
    data['p_user_lat'] = this.pUserLat;
    data['p_user_lon'] = this.pUserLon;
    data['p_user_address_no'] = this.pUserAddressNo;
    data['p_user_address_postal'] = this.pUserAddressPostal;
    data['p_user_address_location'] = this.pUserAddressLocation;
    data['p_user_address_street'] = this.pUserAddressStreet;
    data['p_user_company_name'] = this.pUserCompanyName;
    data['p_user_tax_number'] = this.pUserTaxNumber;
    data['p_user_telegram'] = this.pUserTelegram;
    data['p_user_billing_address'] = this.pUserBillingAddress;
    data['p_user_billing_no'] = this.pUserBillingNo;
    data['p_user_billing_postal'] = this.pUserBillingPostal;
    data['p_user_billing_location'] = this.pUserBillingLocation;
    data['p_user_lang'] = this.pUserLang;
    data['p_user_total_online_ad'] = this.pUserTotalOnlineAd;
    data['p_user_total_bought'] = this.pUserTotalBought;
    data['p_user_total_sold'] = this.pUserTotalSold;
    data['p_user_active_package'] = this.pUserActivePackage;
    data['p_user_bio'] = this.pUserBio;
    data['p_user_stripe_customer_id'] = this.pUserStripeCustomerId;
    data['display_profile_image'] = displayProfileImage;
    data['rating_as_buyer'] = ratingAsBuyer;
    return data;
  }
}
