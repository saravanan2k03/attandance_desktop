import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Dashboard/Presentation/Widgets/hr_dashboard_cards.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
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
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: "23",
                        iconData: Icons.pending_actions,
                        title: "Pending Leave Requests",
                      ).withPadding(padding: EdgeInsets.only(bottom: 07.sp)),
                    ),
                    Expanded(
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: "23",
                        iconData: Icons.person_add,
                        title: "New Joins This Month",
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
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: "23",
                        iconData: Icons.timelapse,
                        title: "Late Check-ins Today",
                      ),
                    ),
                    Expanded(
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: "23",
                        iconData: Icons.devices,
                        title: "Active Devices Logged In",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.small(
                  "Employees on Leave Today",
                  fontSize: 17,
                ).withPadding(padding: EdgeInsets.all(07.sp)),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(07.sp),
                      color: commonColor,
                    ),
                    child: Column(
                      children: [
                        CustomTable(
                          datacolumns: [
                            "Id",
                            "Employee name",
                            "Department",
                            "Designation",
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).withPadding(padding: EdgeInsets.symmetric(horizontal: 07.sp)),
        ),
      ],
    );
  }
}
