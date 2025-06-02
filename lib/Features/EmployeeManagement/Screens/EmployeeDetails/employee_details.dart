import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Features/EmployeeManagement/Constant/employee_management.dart';
import 'package:act/Features/EmployeeManagement/Screens/EmployeeDetails/employee_info_card.dart';
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
          Expanded(flex: 2, child: CustomDrawer(employeeManagement: true)),
          Expanded(
            flex: 12,
            child: Column(
              children: [
                CustomAppbar(),
                Expanded(
                  child: Container(
                    color: const Color(0xffF5F5F5),
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
                                              color: const Color(0xfff5f5f5),
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
    return Column(children: [DashboardUpperWidget(), DashboardLowerWidget()]);
  }
}

class DashboardUpperWidget extends StatelessWidget {
  const DashboardUpperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(
                child: AppText.small("Chart Container", fontSize: 17),
              ),
            ).withPadding(padding: EdgeInsets.symmetric(vertical: 07.sp)),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: DashboardCards().withPadding(
                          padding: EdgeInsets.only(
                            top: 07.sp,
                            left: 07.sp,
                            bottom: 07.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                        ).withPadding(padding: EdgeInsets.all(07.sp)),
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
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                        ).withPadding(
                          padding: EdgeInsets.only(left: 07.sp, bottom: 07.sp),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
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

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(07.sp),
      ),
    );
  }
}

class DashboardLowerWidget extends StatelessWidget {
  const DashboardLowerWidget({super.key});

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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                        ).withPadding(padding: EdgeInsets.only(bottom: 07.sp)),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
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
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
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
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(07.sp),
              ),
            ).withPadding(padding: EdgeInsets.symmetric(horizontal: 07.sp)),
          ),
        ],
      ),
    );
  }
}
