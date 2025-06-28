import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Models/chart_data.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_dashboard_cards.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeDashboardUpperWidget extends StatelessWidget {
  final double monthlyAbsents;
  final double monthlyPresents;
  final double pieleavesTaken;
  final String attendanceThisMonth;
  final String leavesTaken;
  final String lateLogins;
  final String pendingLeaveRequests;

  const EmployeeDashboardUpperWidget({
    super.key,
    required this.monthlyAbsents,
    required this.monthlyPresents,
    required this.pieleavesTaken,
    required this.attendanceThisMonth,
    required this.leavesTaken,
    required this.lateLogins,
    required this.pendingLeaveRequests,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: cardsColors,
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.small(
                        "Monthly Employee Attendance Overview",
                        fontSize: 17,
                      ),
                    ],
                  ),
                  piechartWidget(
                    colorsectionData: [
                      ChartData(
                        code: "Monthly Absents",
                        color: Color(0xff9dbdff),
                        title: "Absent in This Month",
                        value: monthlyAbsents,
                      ),
                      ChartData(
                        code: "Monthly Presents",
                        color: Color(0xffffd09b),
                        title: "Present in This Month",
                        value: monthlyPresents,
                      ),
                      ChartData(
                        code: "Leaves Taken",
                        color: Color(0xfffd8b51),
                        title: "Leaves Taken",
                        value: pieleavesTaken,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 05,
                            backgroundColor: Color(0xff9dbdff),
                          ),
                          07.sp.width,
                          AppText.small("Absent in This Month", fontSize: 16),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 05,
                            backgroundColor: Color(0xffffd09b),
                          ),
                          07.sp.width,
                          AppText.small("Present in This Month", fontSize: 17),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 05,
                            backgroundColor: Color(0xfffd8b51),
                          ),
                          07.sp.width,
                          AppText.small("Leaves Taken", fontSize: 17),
                        ],
                      ),
                    ],
                  ).withPadding(
                    padding: EdgeInsets.symmetric(horizontal: 07.sp),
                  ),
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
                        child: EmployeeDashboardCards(
                          aggregatedString: "Total",
                          aggregationCount: attendanceThisMonth,
                          iconData: Icons.calendar_today,
                          title: "Attendance This Month",
                        ).withPadding(
                          padding: EdgeInsets.only(
                            top: 07.sp,
                            left: 07.sp,
                            bottom: 07.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: EmployeeDashboardCards(
                          aggregatedString: "Total",
                          aggregationCount: leavesTaken,
                          iconData: Icons.beach_access,
                          title: "Leaves Taken",
                        ).withPadding(
                          padding: EdgeInsets.only(
                            left: 07.sp,
                            bottom: 07.sp,
                            top: 07.sp,
                            right: 07.sp,
                          ),
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
                          aggregatedString: "Total",
                          aggregationCount: lateLogins,
                          iconData: Icons.timelapse,
                          title: "Late Logins",
                        ).withPadding(
                          padding: EdgeInsets.only(left: 07.sp, bottom: 07.sp),
                        ),
                      ),
                      Expanded(
                        child: EmployeeDashboardCards(
                          aggregatedString: "Total",
                          aggregationCount: pendingLeaveRequests,
                          iconData: Icons.pending_actions,
                          title: "Pending Leave Requests",
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
      ),
    );
  }
}
