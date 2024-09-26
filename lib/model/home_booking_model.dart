class HomeBookingModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  HomeBookingModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  HomeBookingModel.fromJson(Map<String, dynamic> json) {
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
  dynamic houseNUmber;
  dynamic address;
  dynamic street;
  dynamic postalCode;
  dynamic city;
  dynamic status;
  dynamic statusCreatedAt;
  dynamic statusUpdatedAt;
  Category? category;
  User? user;

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
      this.houseNUmber,
      this.address,
      this.street,
      this.postalCode,
      this.city,
      this.status,
      this.statusCreatedAt,
      this.statusUpdatedAt,
      this.category,
      this.user});

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
    houseNUmber = json['house_number'];
    address = json['address'];
    street = json['street'];
    postalCode = json['postal_code'];
    city = json['city'];
    status = json['status'];
    statusCreatedAt = json['status_created_at'];
    statusUpdatedAt = json['status_updated_at'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
    data['house_number']=houseNUmber ;
    data['address'] = address;
    data['street'] = street;
    data['postal_code'] = postalCode;
    data['city'] = city;
    data['status'] = status;
    data['status_created_at'] = statusCreatedAt;
    data['status_updated_at'] = statusUpdatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Category {
  dynamic categoryId;
  dynamic categoryName;
  dynamic categoryNameDe;
  dynamic categoryImage;
  dynamic description;

  Category(
      {this.categoryId,
      this.categoryName,
      this.categoryNameDe,
      this.categoryImage,
      this.description});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryNameDe = json['category_name_de'];
    categoryImage = json['category_image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_name_de'] = categoryNameDe;
    data['category_image'] = categoryImage;
    data['description'] = description;
    return data;
  }
}

class User {
  dynamic pUserId;
  dynamic pUserName;
  dynamic pUserSurname;
  dynamic pUserAddress;
  dynamic pUserLat;
  dynamic pUserLon;
  dynamic displayProfileImage;

  User(
      {this.pUserId,
      this.pUserName,
      this.pUserSurname,
      this.pUserAddress,
      this.pUserLat,
      this.pUserLon,
      this.displayProfileImage});

  User.fromJson(Map<String, dynamic> json) {
    pUserId = json['p_user_id'];
    pUserName = json['p_user_name'];
    pUserSurname = json['p_user_surname'];
    pUserAddress = json['p_user_address'];
    pUserLat = json['p_user_lat'];
    pUserLon = json['p_user_lon'];
    displayProfileImage = json['display_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['p_user_id'] = pUserId;
    data['p_user_name'] = pUserName;
    data['p_user_surname'] = pUserSurname;
    data['p_user_address'] = pUserAddress;
    data['p_user_lat'] = pUserLat;
    data['p_user_lon'] = pUserLon;
    data['display_profile_image'] = displayProfileImage;
    return data;
  }
}
