import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/utils.dart';
import'package:provider/provider.dart';

import '../providers/dashboard_provider/dashboard_provider.dart';

Future getLocationPermission() async {
  LocationPermission permission = await Geolocator.requestPermission();
  print(permission);
  if (permission == LocationPermission.denied) {
    // Provider.of<DashboardProvider>(navigatorKey.currentContext!,listen: false).updateLocationPermission(false);
    // Handle case when user denies permission
    print('User denied permission to access location');
    return "deniedPermission";
  } else if (permission == LocationPermission.deniedForever) {
    // Provider.of<DashboardProvider>(navigatorKey.currentContext!,listen: false).updateLocationPermission(false);
    // Handle case when user permanently denies permission
    print('User permanently denied permission to access location');
    Geolocator.openAppSettings();
    return "deniedForever";
  }

  else {
    // Provider.of<DashboardProvider>(navigatorKey.currentContext!,listen: false).updateLocationPermission(true);
    // Permission granted, get current location
    final position = getCurrentLocation();
    return 'location';
  }
}

Future currentLocation()async{
  LocationSettings locationSettings =const LocationSettings(
    distanceFilter: 10,accuracy: LocationAccuracy.medium
  );
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,locationSettings: locationSettings);
  print("currentpositiodfgedn${position.latitude}+${position.longitude}");
  SessionManager.setLat = position.latitude.toString();
  SessionManager.setLng = position.longitude.toString();
  return position;
}

Future getCurrentLocation() async {
  try {
    Position? lastPosition = await Geolocator.getLastKnownPosition();
    print("${lastPosition!.latitude}+${lastPosition!.longitude}");
    currentLocation().then((val){
      if(val!=null){
      }
      else{
        /// again call to get the location
        currentLocation();
        Future.delayed(const Duration(seconds: 3),(){
          SessionManager.setLat = lastPosition.latitude.toString();
          SessionManager.setLng = lastPosition.longitude.toString();
        });
    }
  });}
  catch (e) {
    currentLocation();
    print('Error: $e');
  }

}
