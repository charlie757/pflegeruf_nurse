import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/providers/dashboard_provider/dashboard_provider.dart';
import 'package:nurse/providers/dashboard_provider/notification_provider.dart';
import 'package:nurse/providers/dashboard_provider/profile_provider.dart';
import 'package:nurse/screens/dashboard/booking/booking_screen.dart';
import 'package:nurse/screens/dashboard/home_screen.dart';
import 'package:nurse/screens/dashboard/profile_screen.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../utils/location_service.dart';

class DashboardScreen extends StatefulWidget {
  final int index;
  const DashboardScreen({this.index = 0});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>with WidgetsBindingObserver {
  @override
  void initState(){
    callInitFunction();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        getCurrentLocation();
        print('App is inactive');
        break;
      case AppLifecycleState.paused:
        getCurrentLocation();
        print('App is paused');
        break;
      case AppLifecycleState.resumed:
       await getCurrentLocation();
        if (SessionManager.token.isNotEmpty) {
          Provider.of<NotificationProvider>(navigatorKey.currentContext!,
              listen: false)
              .unreadNotificationApiFunction();
        }
        break;
      case AppLifecycleState.detached:
        getCurrentLocation();
        print('App is detached');
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  callInitFunction()async {
    final myProvider = Provider.of<DashboardProvider>(context, listen: false);
    myProvider.selectedIndex = widget.index;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      profileProvider.getProfileApiFunction(true);
    });
    await Permission.storage.request();
  }

  List screenList = [
    const HomeScreen(),
    const BookingsScreen(),
    const ProfileScreen()
  ];

  var latitude = "";
  var longitude = "";
  Position? currentPosition;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<DashboardProvider>(builder: (context, myProvider, child) {
        return PopScope(
          canPop: false,
          onPopInvoked: (val) {
            myProvider.onWillPop();
          },
          child: Scaffold(
            backgroundColor: AppColor.whiteColor,
            body: screenList[myProvider.selectedIndex],
            bottomNavigationBar: Container(
              height: 60,
              decoration: BoxDecoration(color: AppColor.whiteColor, boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 20,
                    color: AppColor.shadowColor)
              ]),
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomNavigationItems(AppImages.bottomIcon1, 0, myProvider,
                      () {
                    print(SessionManager.token);
                        getLocationPermission();
                    myProvider.updateSelectedIndex(0);
                  }),
                  bottomNavigationItems(AppImages.bottomIcon2, 1, myProvider,
                      () {
                        getLocationPermission();
                    myProvider.updateSelectedIndex(1);
                  }),
                  bottomNavigationItems(AppImages.bottomIcon3, 2, myProvider,
                      () {
                        getLocationPermission();
                    myProvider.updateSelectedIndex(2);
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  bottomNavigationItems(
      String icon, int index, DashboardProvider provider, Function() onTap) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                icon,
                height: 24,
                width: 24,
                color: provider.selectedIndex == index
                    ? AppColor.appTheme
                    : const Color(0xffA9A9A9),
              ),
              ScreenSize.height(11),
              Container(
                height: 4,
                width: 51,
                decoration: BoxDecoration(
                    color: provider.selectedIndex == index
                        ? AppColor.appTheme
                        : AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
