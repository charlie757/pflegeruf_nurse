import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.appLogo),
      ),
    );
  }
}
