import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Dashboard/Presentation/Widgets/hr_dashboard_cards.dart';
import 'package:act/Features/Dashboard/Presentation/Widgets/monthly_attendance_overview.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HrDashboardUpperWidget extends StatelessWidget {
  const HrDashboardUpperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: cardsColors,
              borderRadius: BorderRadius.circular(07.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.small("Monthly Attendance Overview", fontSize: 17),
                MonthlyAttendanceOverview(),
              ],
            ).withPadding(padding: EdgeInsets.all(07.sp)),
          ).withPadding(padding: EdgeInsets.symmetric(vertical: 07.sp)),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: "23",
                        iconData: Icons.group,
                        title: "Total Employees",
                      ).withPadding(
                        padding: EdgeInsets.only(
                          top: 07.sp,
                          left: 07.sp,
                          bottom: 07.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: "23",
                        iconData: Icons.how_to_reg,
                        title: "Employees Present Today",
                      ).withPadding(padding: EdgeInsets.all(07.sp)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: "23",
                        iconData: Icons.person_off,
                        title: "Employees Absent Today",
                      ).withPadding(
                        padding: EdgeInsets.only(left: 07.sp, bottom: 07.sp),
                      ),
                    ),
                    Expanded(
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: "23",
                        iconData: Icons.beach_access,
                        title: "Employees on Leave Today",
                      ).withPadding(
                        padding: EdgeInsets.only(
                          left: 07.sp,
                          bottom: 07.sp,
                          right: 07.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
