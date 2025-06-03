import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Features/EmployeeManagement/Constant/employee_management.dart';
import 'package:act/Features/EmployeeManagement/Screens/EmployeeDetails/employee_info_card.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_dashboard_upper_widget.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_dashboard_lower_widget.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_tabbar.dart';
import 'package:act/Features/EmployeeManagement/Screens/EmployeeLeaveRequest/employee_leave_request.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({super.key});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  void changetabbar(
    bool employeeDashboard,
    bool employeeInformation,
    bool leaveRequest,
  ) {
    employeeDashboardvar = employeeDashboard;
    employeeInformationvar = employeeInformation;
    leaveRequestvar = leaveRequest;
  }

  @override
  void initState() {
    employeeDashboardvar = true;
    employeeInformationvar = false;
    leaveRequestvar = false;
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
              employeeManagement: true,
              employeeDetails: true,
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
                          // color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppText.small(
                                    "Employee Management",
                                    fontSize: 18,
                                  ),
                                  07.sp.width,
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  07.sp.width,
                                  AppText.small(
                                    "Employee Details",
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                              AppText.medium("Employee Details", fontSize: 18),
                              07.sp.width,
                            ],
                          ),
                        ),
                        15.height,
                        Expanded(
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: EmployeeInfoCard(),
                              ),
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
                                                      changetabbar(
                                                        employeeDashboardvar =
                                                            true,
                                                        employeeInformationvar =
                                                            false,
                                                        leaveRequestvar = false,
                                                      );
                                                    });
                                                  },

                                                  child: TabbarCard(
                                                    cardenable:
                                                        employeeDashboardvar,
                                                    label: "Employee Dashboard",
                                                  ),
                                                ),

                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      changetabbar(
                                                        employeeDashboardvar =
                                                            false,
                                                        employeeInformationvar =
                                                            false,
                                                        leaveRequestvar = true,
                                                      );
                                                    });
                                                  },
                                                  child: TabbarCard(
                                                    cardenable: leaveRequestvar,
                                                    label: "Leave Request",
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
                                        visible: leaveRequestvar,
                                        replacement: Expanded(
                                          child: EmployeeDashboard()
                                              .withPadding(
                                                padding: EdgeInsets.all(07.sp),
                                              ),
                                        ),
                                        child: EmployeeLeaveRequest(),
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

class EmployeeDashboard extends StatelessWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmployeeDashboardUpperWidget(),
        EmployeeDashboardLowerWidget(),
      ],
    );
  }
}
