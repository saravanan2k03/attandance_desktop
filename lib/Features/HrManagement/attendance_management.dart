import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_tabbar.dart';
import 'package:act/Features/HrManagement/Screens/AttendanceDetails/attendance_details_card.dart';
import 'package:act/Features/HrManagement/Screens/LeaveRequestAction/leave_request_action.dart';
import 'package:act/Features/HrManagement/Screens/PayrollDetails/payroll_details_card.dart';
import 'package:act/Features/HrManagement/Widgets/device_info.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class AttendanceManagement extends StatefulWidget {
  const AttendanceManagement({super.key});

  @override
  State<AttendanceManagement> createState() => _AttendanceManagementState();
}

class _AttendanceManagementState extends State<AttendanceManagement> {
  // Local tab state variables
  bool attendanceDetailsTab = true;
  bool payrollDetailsTab = false;
  bool leaveRequestTab = false;

  void changeTab({
    required bool attendance,
    required bool payroll,
    required bool leave,
  }) {
    setState(() {
      attendanceDetailsTab = attendance;
      payrollDetailsTab = payroll;
      leaveRequestTab = leave;
    });
  }

  @override
  void initState() {
    super.initState();
    changeTab(attendance: true, payroll: false, leave: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomDrawer(
              payrollManagement: true,
              attendanceDetails: true,
            ),
          ),
          Expanded(
            flex: 12,
            child: Column(
              children: [
                CustomAppbar(),
                Expanded(
                  child: Container(
                    color: cardsColors,
                    child: Column(
                      children: [
                        SizedBox(
                          width: calcSize(context).longestSide,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppText.small(
                                    "HR Management",
                                    fontSize: 11.sp,
                                  ),
                                  07.sp.width,
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  07.sp.width,
                                  AppText.small(
                                    "Attendance Details",
                                    fontSize: 11.sp,
                                  ),
                                ],
                              ),
                              AppText.medium(
                                "Attendance Details",
                                fontSize: 11.sp,
                              ),
                              07.sp.width,
                            ],
                          ),
                        ),
                        15.height,
                        Expanded(
                          child: Row(
                            children: [
                              const Expanded(flex: 3, child: DeviceInfoCard()),
                              07.width,
                              Expanded(
                                flex: 10,
                                child: Container(
                                  height: calcSize(context).longestSide,
                                  width: calcSize(context).longestSide,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(07.sp),
                                  ),
                                  child: Column(
                                    children: [
                                      // Tabbar UI
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: cardsColors,
                                              borderRadius:
                                                  BorderRadius.circular(07.sp),
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    changeTab(
                                                      attendance: true,
                                                      payroll: false,
                                                      leave: false,
                                                    );
                                                  },
                                                  child: TabbarCard(
                                                    cardenable:
                                                        attendanceDetailsTab,
                                                    label: "Attendance Details",
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    changeTab(
                                                      attendance: false,
                                                      payroll: true,
                                                      leave: false,
                                                    );
                                                  },
                                                  child: TabbarCard(
                                                    cardenable:
                                                        payrollDetailsTab,
                                                    label: "Payroll Details",
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    changeTab(
                                                      attendance: false,
                                                      payroll: false,
                                                      leave: true,
                                                    );
                                                  },
                                                  child: TabbarCard(
                                                    cardenable: leaveRequestTab,
                                                    label: "Leave Action",
                                                  ),
                                                ),
                                              ],
                                            ).withPadding(
                                              padding: EdgeInsets.all(07.sp),
                                            ),
                                          ).withPadding(
                                            padding: EdgeInsets.all(07.sp),
                                          ),
                                        ],
                                      ),
                                      // Tab Content
                                      Expanded(
                                        child: Builder(
                                          builder: (context) {
                                            if (attendanceDetailsTab) {
                                              return AttendanceDetailsCard()
                                                  .withPadding(
                                                    padding: EdgeInsets.all(
                                                      07.sp,
                                                    ),
                                                  );
                                            } else if (payrollDetailsTab) {
                                              return PayrollDetails();
                                            } else if (leaveRequestTab) {
                                              return LeaveRequestAction();
                                            } else {
                                              return const Center(
                                                child: Text("No tab selected"),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).withPadding(padding: EdgeInsets.all(10.sp)),
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
