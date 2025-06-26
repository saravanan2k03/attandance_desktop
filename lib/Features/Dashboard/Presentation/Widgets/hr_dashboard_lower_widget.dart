import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Dashboard/Presentation/Widgets/hr_dashboard_cards.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/HrManagement/Models/hr_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HrDashboardLowerWidget extends StatelessWidget {
  final String pendingLeaveRequests;
  final String newJoinsThisMonth;
  final String lateCheckinsToday;
  final String activeDevicesLoggedIn;
  final List<EmployeeLeaveToday> employeeLeaveToday;
  const HrDashboardLowerWidget({
    super.key,
    required this.pendingLeaveRequests,
    required this.newJoinsThisMonth,
    required this.lateCheckinsToday,
    required this.activeDevicesLoggedIn,
    required this.employeeLeaveToday,
  });

  @override
  Widget build(BuildContext context) {
    List<DataRow> buildEmployeeLeaveTableRows(
      List<EmployeeLeaveToday> employeeLeaveTodayList,
    ) {
      return employeeLeaveTodayList.map((e) {
        return DataRow(
          cells: [
            DataCell(Text(e.employeeId.toString())),
            DataCell(Text(e.fullName)),
            DataCell(Text(e.department)),
            DataCell(Text(e.designation)),
          ],
        );
      }).toList();
    }

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
                        aggregationCount: pendingLeaveRequests,
                        iconData: Icons.pending_actions,
                        title: "Pending Leave Requests",
                      ).withPadding(padding: EdgeInsets.only(bottom: 07.sp)),
                    ),
                    Expanded(
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: newJoinsThisMonth,
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
                        aggregationCount: lateCheckinsToday,
                        iconData: Icons.timelapse,
                        title: "Late Check-ins Today",
                      ),
                    ),
                    Expanded(
                      child: HrDashboardCards(
                        aggregatedString: "Total",
                        aggregationCount: activeDevicesLoggedIn,
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
                          dataRow: buildEmployeeLeaveTableRows(
                            employeeLeaveToday,
                          ),
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
