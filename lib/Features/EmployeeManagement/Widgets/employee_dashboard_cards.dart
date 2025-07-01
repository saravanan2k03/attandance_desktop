import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeDashboardCards extends StatelessWidget {
  final String aggregatedString;
  final String aggregationCount;
  final IconData iconData;
  final String title;
  const EmployeeDashboardCards({
    super.key,
    required this.aggregatedString,
    required this.aggregationCount,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardsColors,
        borderRadius: BorderRadius.circular(07.sp),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.small(aggregatedString, fontSize: 11.sp),
                AppText.large(aggregationCount, fontSize: 11.sp),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ).withPadding(padding: EdgeInsets.symmetric(horizontal: 07.sp)),
          Expanded(
            flex: 2,
            child: Container(
              child: Row(
                children: [
                  Icon(iconData, color: Colors.black),
                  07.sp.width,
                  Expanded(
                    child: AppText.small(
                      title,
                      fontSize: 11.sp,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ).withPadding(padding: EdgeInsets.all(07.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
