import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/screens/auth/login_screen.dart';
import 'package:nurse/screens/dashboard/dashboard_screen.dart';
import 'package:nurse/screens/onboarding_screen.dart';
import 'package:nurse/utils/session_manager.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  @override
  void initState() {
    getLocationPermission();
    callNavigate();
    super.initState();
  }

  callNavigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (SessionManager.firstTimeOpenApp) {
        if (SessionManager.token.isNotEmpty) {
          AppRoutes.pushReplacementNavigation(const DashboardScreen());
        } else {
          AppRoutes.pushReplacementNavigation(const LoginScreen());
        }
      } else {
        AppRoutes.pushReplacementNavigation(const OnboardingScreen());
      }
    });
  }

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
      print(position);
      SessionManager.setLat = position.latitude.toString();
      SessionManager.setLng = position.longitude.toString();
      return position;
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.appLogo),
      ),
    );
  }
}
