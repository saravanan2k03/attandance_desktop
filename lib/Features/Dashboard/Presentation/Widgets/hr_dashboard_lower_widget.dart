import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HrDashboardLowerWidget extends StatelessWidget {
  const HrDashboardLowerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardsColors,
                          borderRadius: BorderRadius.circular(07.sp),
                        ),
                      ).withPadding(padding: EdgeInsets.only(bottom: 07.sp)),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardsColors,
                          borderRadius: BorderRadius.circular(07.sp),
                        ),
                      ).withPadding(
                        padding: EdgeInsets.only(bottom: 07.sp, left: 07.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardsColors,
                          borderRadius: BorderRadius.circular(07.sp),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardsColors,
                          borderRadius: BorderRadius.circular(07.sp),
                        ),
                      ).withPadding(padding: EdgeInsets.only(left: 07.sp)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: cardsColors,
              borderRadius: BorderRadius.circular(07.sp),
            ),
            child: Center(child: AppText.small("Table", fontSize: 17)),
          ).withPadding(padding: EdgeInsets.symmetric(horizontal: 07.sp)),
        ),
      ],
    );
  }
}
