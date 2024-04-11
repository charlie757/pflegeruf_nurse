class PatientBookingModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  PatientBookingModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  PatientBookingModel.fromJson(Map<String, dynamic> json) {
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
  MyListing? myListing;

  Data({this.myListing});

  Data.fromJson(Map<String, dynamic> json) {
    myListing = json['myListing'] != null
        ? MyListing.fromJson(json['myListing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (myListing != null) {
      data['myListing'] = myListing!.toJson();
    }
    return data;
  }
}

class MyListing {
  dynamic bookingId;
  dynamic bookingNumber;
  dynamic bookingDate;
  dynamic bookingStatus;
  Patient? patient;
  Service? service;

  MyListing(
      {this.bookingId,
      this.bookingNumber,
      this.bookingDate,
      this.bookingStatus,
      this.patient,
      this.service});

  MyListing.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingNumber = json['booking_number'];
    bookingDate = json['booking_date'];
    bookingStatus = json['booking_status'];
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['booking_id'] = bookingId;
    data['booking_number'] = bookingNumber;
    data['booking_date'] = bookingDate;
    data['booking_status'] = bookingStatus;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class Patient {
  dynamic id;
  dynamic name;
  dynamic photo;
  dynamic insurance;
  dynamic insuranceNumber;
  dynamic dob;
  dynamic address;
  dynamic street;
  dynamic postalCode;
  dynamic city;
  dynamic rating;

  Patient(
      {this.id,
      this.name,
      this.photo,
      this.insurance,
      this.insuranceNumber,
      this.dob,
      this.address,
      this.street,
      this.postalCode,
      this.city,
      this.rating});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    insurance = json['insurance'];
    insuranceNumber = json['insurance_number'];
    dob = json['dob'];
    address = json['address'];
    street = json['street'];
    postalCode = json['postal-code'];
    city = json['city'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['insurance'] = insurance;
    data['insurance_number'] = insuranceNumber;
    data['dob'] = dob;
    data['address'] = address;
    data['street'] = street;
    data['postal-code'] = postalCode;
    data['city'] = city;
    data['rating'] = rating;
    return data;
  }
}

class Service {
  dynamic id;
  dynamic name;

  Service({this.id, this.name});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
