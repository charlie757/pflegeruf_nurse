import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nurse/languages/languages.dart';
import 'package:nurse/providers/auth_provider/change_password_provider.dart';
import 'package:nurse/providers/auth_provider/forgot_password_provider.dart';
import 'package:nurse/providers/auth_provider/forgot_verification_provider.dart';
import 'package:nurse/providers/auth_provider/login_provider.dart';
import 'package:nurse/providers/dashboard_provider/booking/bookings_provider.dart';
import 'package:nurse/providers/dashboard_provider/booking/patient_details_provider.dart';
import 'package:nurse/providers/dashboard_provider/booking/review_provider.dart';
import 'package:nurse/providers/dashboard_provider/booking/show_navigation_provider.dart';
import 'package:nurse/providers/dashboard_provider/dashboard_provider.dart';
import 'package:nurse/providers/dashboard_provider/home_provider.dart';
import 'package:nurse/providers/dashboard_provider/notification_provider.dart';
import 'package:nurse/providers/dashboard_provider/profile_provider.dart';
import 'package:nurse/providers/onboarding_provider.dart';
import 'package:nurse/screens/splash_screen.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

String selectedLanguage = 'en';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
        ChangeNotifierProvider(create: (_) => ForgotVerificationProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => BookingsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => PatientDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => ShowNavigationProvider()),
      ],
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        title: 'Pflegeruf PflegerIn',
        translations: Languages(),
        locale: Locale(selectedLanguage),
        fallbackLocale: const Locale('en'),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashSCreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
