import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:nurse/widgets/ratingwidget.dart';
import 'package:readmore/readmore.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: StringKey.reviews.tr, showLeading: true),
      body: ListView.separated(
          separatorBuilder: (context, sp) {
            return Column(
              children: [
                ScreenSize.height(28),
                Container(
                  height: 1,
                  color: AppColor.appTheme.withOpacity(.2),
                )
              ],
            );
          },
          itemCount: 4,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return reviewsUI();
          }),
    );
  }

  Widget reviewsUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
      ),
      padding: const EdgeInsets.only(left: 16, right: 14, top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/dummyProfile.png',
                height: 46,
                width: 46,
              ),
              ScreenSize.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alexandra Will',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    ScreenSize.height(1),
                    const getText(
                        title: 'Yoga Class',
                        size: 14,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.lightTextColor,
                        fontWeight: FontWeight.w400)
                  ],
                ),
              ),
              const getText(
                  title: 'Oct 23, 22',
                  size: 12,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.lightTextColor,
                  fontWeight: FontWeight.w400)
            ],
          ),
          ScreenSize.height(12),
          Padding(
            padding: const EdgeInsets.only(left: 52),
            child: ratingWidget(18),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 52, top: 12),
            child: ReadMoreText(
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking',
              trimLines: 3,
              colorClickableText: Colors.pink,
              lessStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColor.blueColor,
                  fontFamily: FontFamily.poppinsRegular),
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColor.lightTextColor,
                  fontFamily: FontFamily.poppinsRegular),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'read more',
              trimExpandedText: ' read less',
              moreStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColor.blueColor,
                  fontFamily: FontFamily.poppinsRegular),
            ),
          ),
        ],
      ),
    );
  }
}
