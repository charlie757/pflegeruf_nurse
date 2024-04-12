import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/network_imge_helper.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/providers/dashboard_provider/booking/bookings_provider.dart';
import 'package:nurse/screens/dashboard/booking/patient_details_screen.dart';
import 'package:nurse/utils/timeformat.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:nurse/widgets/no_data_widget.dart';
import 'package:provider/provider.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<BookingsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      provider.bookingApiFunction(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: StringKey.bookings.tr),
        body: Consumer<BookingsProvider>(builder: (context, myProvider, child) {
          return myProvider.model != null &&
                  myProvider.model!.data != null &&
                  myProvider.model!.data!.myListing!.isNotEmpty
              ? ListView.separated(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 40),
                  separatorBuilder: (context, sp) {
                    return ScreenSize.height(10);
                  },
                  itemCount: myProvider.model!.data!.myListing!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return bookingsWidget(myProvider, index);
                  })
              : Center(
                  child: noDataWidget(),
                );
        }));
  }

  Widget bookingsWidget(BookingsProvider provider, int index) {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(PatientDetailSreen(
          bookingId:
              provider.model!.data!.myListing![index].bookingId.toString(),
        )).then((value) {
          provider.bookingApiFunction(false);
        });
      },
      child: Container(
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
            const EdgeInsets.only(left: 20, top: 20, bottom: 25, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: provider.model!.data!.myListing![index].user != null &&
                          provider.model!.data!.myListing![index].user!
                                  .displayProfileImage !=
                              null
                      ? NetworkImageHelper(
                          img: provider.model!.data!.myListing![index].user!
                              .displayProfileImage,
                          height: 70.0,
                          width: 70.0,
                        )
                      : const SizedBox(
                          height: 70,
                          width: 70,
                        ),
                ),
                ScreenSize.width(20),
                Flexible(
                  child: getText(
                      title: provider.model!.data!.myListing![index].user !=
                              null
                          ? "${provider.model!.data!.myListing![index].user!.pUserName != null ? provider.model!.data!.myListing![index].user!.pUserName.toString().substring(0).toUpperCase()[0] + provider.model!.data!.myListing![index].user!.pUserName.toString().substring(1) : ''} ${provider.model!.data!.myListing![index].user!.pUserSurname != null ? provider.model!.data!.myListing![index].user!.pUserSurname.toString().substring(0).toUpperCase()[0] + provider.model!.data!.myListing![index].user!.pUserSurname.toString().substring(1) : ''}"
                          : '',
                      size: 20,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            ScreenSize.height(19),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(
                    title: "${StringKey.bookingDate.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                getText(
                    title: provider.model!.data!.myListing![index]
                                .productCreatedAt !=
                            null
                        ? TimeFormat.convertBookingDate(provider
                            .model!.data!.myListing![index].productCreatedAt)
                        : '',
                    size: 14,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
            ScreenSize.height(9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(
                    title: "${StringKey.serviceName.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                Flexible(
                  child: getText(
                      title: provider.model!.data!.myListing![index].category !=
                              null
                          ? provider.model!.data!.myListing![index].category!
                                  .categoryName ??
                              ""
                          : "",
                      size: 14,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
