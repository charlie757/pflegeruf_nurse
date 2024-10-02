import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/network_imge_helper.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/model/review_model.dart';
import 'package:nurse/utils/timeformat.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:nurse/widgets/no_data_widget.dart';
import 'package:nurse/widgets/ratingwidget.dart';
import 'package:readmore/readmore.dart';

import '../../../helper/appimages.dart';

// ignore: must_be_immutable
class ReviewsScreen extends StatefulWidget {
  ReviewModel? model;
  ReviewsScreen({this.model});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.model!.data!.ratings);
    return Scaffold(
      appBar: appBar(
          title: getTranslated('reviews', context)!.tr, showLeading: true),
      body: widget.model != null && widget.model!.data != null
          ? widget.model!.data!.ratings!.isNotEmpty
              ? ListView.separated(
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
                  itemCount: widget.model!.data!.ratings!.length,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return reviewsUI(index);
                  })
              : Align(alignment: Alignment.center, child: noDataWidget())
          : Container(),
    );
  }

  Widget reviewsUI(int index) {
    var model = widget.model!.data!.ratings![index];
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
              model.byPatient!=null&&model.byPatient!.displayProfileImage!=null&&model.byPatient!.displayProfileImage.toString().isNotEmpty?
              ClipOval(
                child: NetworkImageHelper(
                  img: model.byPatient!.displayProfileImage,
                  height: 46.0,
                  width: 46.0,
                ),
              ):Container(
              height: 46.0,
        width: 46.0,
        child: Image.asset(AppImages.bottomIcon3),
      ),
              ScreenSize.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.byPatient != null &&
                              model.byPatient!.pUserName != null
                          ? "${model.byPatient!.pUserName != null ? model.byPatient!.pUserName.toString().substring(0).toUpperCase()[0] + model.byPatient!.pUserName.toString().substring(1) : ''} ${model.byPatient!.pUserSurname != null ? model.byPatient!.pUserSurname.toString().substring(0).toUpperCase()[0] + model.byPatient!.pUserSurname.toString().substring(1) : ''}"
                          : '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    ScreenSize.height(1),
                    getText(
                        title: model.product != null
                            ? model.product!.productTitle ?? ''
                            : '',
                        size: 14,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.lightTextColor,
                        fontWeight: FontWeight.w400)
                  ],
                ),
              ),
              getText(
                  title: model.ratingCreatedAt != null
                      ? TimeFormat.convertReviewDate(model.ratingCreatedAt)
                      : "",
                  size: 12,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.lightTextColor,
                  fontWeight: FontWeight.w400)
            ],
          ),
          ScreenSize.height(12),
          model.ratingStar != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 52),
                  child: ratingWidget(18,
                      initalRating: double.parse(model.ratingStar.toString())),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(left: 52, top: 12),
            child: ReadMoreText(
              model.ratingDesc ?? '',
              trimLines: 3,
              colorClickableText: Colors.pink,
              lessStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColor.blueColor,
                  fontFamily: FontFamily.poppinsRegular),
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColor.lightTextColor,
                  fontFamily: FontFamily.poppinsRegular),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'read more',
              trimExpandedText: ' read less',
              moreStyle: const TextStyle(
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
