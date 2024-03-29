// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nurse/helper/appcolor.dart';

class NetworkImageHelper extends StatelessWidget {
  final img;
  final width;
  final height;
  final isAnotherColorOfLodingIndicator;
  const NetworkImageHelper(
      {super.key,
      this.img,
      this.width,
      this.height,
      this.isAnotherColorOfLodingIndicator = false});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: img,
      width: width,
      height: height,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              color: isAnotherColorOfLodingIndicator
                  ? AppColor.redColor
                  : AppColor.appTheme,
              strokeWidth: 2,
              value: downloadProgress.progress)),
      // errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
