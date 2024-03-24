import 'package:flutter/material.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';

class AppButton extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final isLoading;
  final Function() onTap;
  const AppButton({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.buttonColor,
    this.textColor = Colors.white,
    this.isLoading = false,
    required this.onTap,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: widget.buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColor.whiteColor,
                ),
              )
            : getText(
                title: widget.title,
                size: 16,
                fontFamily: FontFamily.poppinsSemiBold,
                color: widget.textColor,
                fontWeight: FontWeight.w600),
      ),
    );
  }
}
