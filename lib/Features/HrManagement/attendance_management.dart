import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_tabbar.dart';
import 'package:act/Features/HrManagement/Constants/hr_management_constant.dart';
import 'package:act/Features/HrManagement/Screens/AttendanceDetails/attendance_details_card.dart';
import 'package:act/Features/HrManagement/Widgets/device_info.dart';
import 'package:act/Features/HrManagement/Screens/PayrollDetails/payroll_details_card.dart';
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
  void changetabbar(bool attendanceDetails, bool payrollDetails) {
    attendanceDetailsvar = attendanceDetails;
    payrollDetailsvar = payrollDetails;
  }

  @override
  void initState() {
    attendanceDetailsvar = true;
    payrollDetailsvar = false;
    super.initState();
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
                          // height: 35.sp,
                          width: calcSize(context).longestSide,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppText.small("HR Management", fontSize: 18),
                                  07.sp.width,
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  07.sp.width,
                                  AppText.small(
                                    "Attendance Details",
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                              AppText.medium(
                                "Attendance Details",
                                fontSize: 18,
                              ),
                              07.sp.width,
                            ],
                          ),
                        ),
                        15.height,
                        Expanded(
                          child: Row(
                            children: [
                              const Expanded(flex: 2, child: DeviceInfoCard()),
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
                                                    setState(() {
                                                      changetabbar(true, false);
                                                    });
                                                  },

                                                  child: TabbarCard(
                                                    cardenable:
                                                        attendanceDetailsvar,
                                                    label: "Attendance Details",
                                                  ),
                                                ),

                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      changetabbar(false, true);
                                                    });
                                                  },
                                                  child: TabbarCard(
                                                    cardenable:
                                                        payrollDetailsvar,
                                                    label: "Payroll Details",
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
                                      Visibility(
                                        visible: payrollDetailsvar,
                                        replacement: Expanded(
                                          child: AttendanceDetailsCard()
                                              .withPadding(
                                                padding: EdgeInsets.all(07.sp),
                                              ),
                                        ),
                                        child: PayrollDetailsCard(),
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
