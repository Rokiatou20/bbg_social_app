import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../configuration/colors.dart';

class CustomButton extends StatelessWidget {
  final Function () onTap;
  final String title;
  final Color? bgColor;
  final Color? titleColor;
  final double? width;
  final double? height;
  const CustomButton({super.key,
    required this.title,
    required this.onTap,
    this.bgColor,
    this.titleColor,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 6.h,
      padding:  EdgeInsets.only(
        left: 8.w,
        right: 8.w
      ),
      child: ElevatedButton(
        onPressed:onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              bgColor??AppColors.secondary
          ),
        ),
        child:Text(title,style:
        TextStyle(
          fontWeight: FontWeight.bold,
          color: titleColor??Colors.white,
        ),),
      ),
    );
  }
}