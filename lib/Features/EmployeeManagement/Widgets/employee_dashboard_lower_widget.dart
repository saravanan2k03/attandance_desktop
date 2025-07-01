import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_dashboard.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_dashboard_cards.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeDashboardLowerWidget extends StatelessWidget {
  final String absentinThisMonth;
  final String overtimeWorking;
  final String clockIn;
  final String punchOut;
  final List<AttendanceTableData> tableData;
  const EmployeeDashboardLowerWidget({
    super.key,
    required this.absentinThisMonth,
    required this.overtimeWorking,
    required this.clockIn,
    required this.punchOut,
    required this.tableData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: EmployeeDashboardCards(
                          aggregatedString: "Total",
                          aggregationCount: absentinThisMonth,
                          iconData: Icons.person_off,
                          title: "Absent in This Month",
                        ).withPadding(padding: EdgeInsets.only(bottom: 07.sp)),
                      ),
                      Expanded(
                        child: EmployeeDashboardCards(
                          aggregatedString: "Total",
                          aggregationCount: overtimeWorking,
                          iconData: Icons.alarm_on,
                          title: "Overtime Working",
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
                        child: EmployeeDashboardCards(
                          aggregatedString: "Time",
                          aggregationCount: clockIn,
                          iconData: Icons.login,
                          title: "Clock In",
                        ),
                      ),
                      Expanded(
                        child: EmployeeDashboardCards(
                          aggregatedString: "Time",
                          aggregationCount: punchOut,
                          iconData: Icons.logout,
                          title: "Punch Out",
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
                    "This Month's Attendance Log",
                    fontSize: 11.sp,
                  ).withPadding(padding: EdgeInsets.all(07.sp)),
                  07.sp.height,
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration().withBorderRadius(
                        color: commonColor,
                        borderRadius: BorderRadius.circular(07.sp),
                      ),
                      child: Column(
                        children: [
                          CustomTable(
                            datacolumns: [
                              "Id",
                              "Date",
                              "Punch-In",
                              "Punch-Out",
                              "Status",
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
      ),
    );
  }
}
