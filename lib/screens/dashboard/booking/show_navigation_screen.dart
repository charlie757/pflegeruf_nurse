import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/utils/map_utils.dart';

class ShowNavigationScreen extends StatefulWidget {
  final String lat;
  final String lng;
  final String address;
  final String city;
  final String street;
  final String postalCode;
  final String fullAddress;
  const ShowNavigationScreen(
      {required this.lat,
      required this.lng,
      required this.address,
      required this.city,
      required this.street,
      required this.postalCode,
      required this.fullAddress});

  @override
  State<ShowNavigationScreen> createState() => _ShowNavigationScreenState();
}

class _ShowNavigationScreenState extends State<ShowNavigationScreen> {
  @override
  void initState() {
    // String address = widget.address
    geteLatLong();
    super.initState();
  }

  double lat = 0.0;
  double lng = 0.0;
  geteLatLong() async {
    try {
      List<Location> locations = await locationFromAddress(widget.fullAddress);
      print("shipping${locations[0]}");
      Location location = locations[0]; // Assuming you want the first location
      lat = location.latitude;
      lng = location.longitude;
      setState(() {});
      // sourceLocation = LatLng(pickupLat, pickupLng);
      // destination = LatLng(location.latitude, location.longitude);
      Future.delayed(Duration(seconds: 3), () {
        // getPolyPoints();
      });
    } catch (e) {
      print("e..$e");
    }
  }

  final Completer<GoogleMapController> controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: lat != 0.0
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, lng),
                        zoom: 13.5,
                      ),
                      scrollGesturesEnabled: true, // Enable scrolling
                      zoomGesturesEnabled: true, // Enable zooming
                      markers: {
                        Marker(
                          markerId: MarkerId("pickup"),
                          infoWindow: InfoWindow(
                            title: 'Current Location',
                          ),
                          position: LatLng(lat, lng),
                        ),
                      },
                      onMapCreated: (mapController) {
                        controller.complete(mapController);
                      },
                    ),
                  )
                : Container(),
          ),
          addressWidget()
        ],
      ),
    );
  }

  Widget addressWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: StringKey.deliveryYourOrder.tr,
              size: 17,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
          ScreenSize.height(17),
          Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      color: AppColor.blackColor.withOpacity(.2),
                      blurRadius: 10)
                ]),
            padding:
                const EdgeInsets.only(left: 20, top: 16, bottom: 20, right: 18),
            child: Row(
              children: [
                Image.asset(
                  AppImages.mapLocationIcon,
                  height: 37,
                  width: 20,
                ),
                ScreenSize.width(11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(
                          title: widget.city,
                          size: 15,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(4),
                      getText(
                          title:
                              "${widget.address}, ${widget.street}, ${widget.city}, ${widget.postalCode}",
                          size: 13,
                          fontFamily: FontFamily.poppinsRegular,
                          color: AppColor.lightTextColor,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                )
              ],
            ),
          ),
          ScreenSize.height(30),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: AppButton(
                title: StringKey.openMap.tr,
                height: 54,
                width: double.infinity,
                buttonColor: AppColor.appTheme,
                onTap: () {
                  MapUtils.openMap(lat, lng);
                }),
          ),
          ScreenSize.height(30),
        ],
      ),
    );
  }
}
