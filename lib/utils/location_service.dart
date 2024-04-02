import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle case when user denies permission
      print('User denied permission to access location');
    } else if (permission == LocationPermission.deniedForever) {
      // Handle case when user permanently denies permission
      print('User permanently denied permission to access location');
    } else {
      // Permission granted, get current location
      final position = getCurrentLocation();
      return position;
    }
  }

  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      print('Error: $e');
    }
  }
}
