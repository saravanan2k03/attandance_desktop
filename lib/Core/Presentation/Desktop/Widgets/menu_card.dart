import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class MenuCardsForDesktop extends StatelessWidget {
  final String title;
  final IconData icondata;
  final bool enable;
  final int pageIndex;
  // final PageManagementBloc pageManagementBloc;
  final Color color;
  final double? overallPadding;
  final double? mobileContainerBorderRadius;
  final double? mobileCardIconSize;
  final double? mobileTitleFontSize;
  final double? cardHeight;
  MenuCardsForDesktop({
    super.key,
    required this.title,
    required this.icondata,
    required this.enable,
    required this.pageIndex,
    // required this.pageManagementBloc,
    required this.color,
    this.mobileContainerBorderRadius,
    this.mobileCardIconSize,
    this.mobileTitleFontSize,
    this.overallPadding,
    this.cardHeight,
  });

  var selectedColor = const Color(0xffA5B1C8);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(overallPadding ?? 05.sp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            mobileContainerBorderRadius ?? 05.sp,
          ),
          color: enable ? commonColor : Colors.transparent,
        ),
        child: SizedBox(
          height: cardHeight ?? 05.h,
          width: calcSize(context).longestSide,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Icon(
                  icondata,
                  color: enable ? Colors.black : color,
                  size: mobileCardIconSize ?? 12.sp,
                ),
              ),
              Expanded(
                flex: 5,
                child: AppText.medium(
                  title,
                  fontSize: mobileTitleFontSize ?? 11.sp,
                  fontWeight: FontWeight.w500,
                  color: enable ? Colors.black : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
