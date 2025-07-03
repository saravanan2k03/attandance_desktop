import 'dart:developer';
import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/expansion_menu_widget.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/menu_card.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Core/gen/assets.gen.dart';
import 'package:act/Features/Configuration/confiugration.dart';
import 'package:act/Features/Dashboard/Presentation/dashboard.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/add_employee_data.dart';
import 'package:act/Features/EmployeeManagement/employee_management.dart';
import 'package:act/Features/HrManagement/attendance_management.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends StatelessWidget {
  final bool? dashboard;
  final bool? employeeManagement;
  final bool? payrollManagement;
  final bool? report;
  final bool? allEmployee;
  final bool? addEmployee;
  final bool? employeeDetails;
  final bool? attendanceDetails;
  final bool? configuration;
  const CustomDrawer({
    super.key,
    this.dashboard,
    this.employeeManagement,
    this.payrollManagement,
    this.report,
    this.allEmployee,
    this.addEmployee,
    this.employeeDetails,
    this.attendanceDetails,
    this.configuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          end: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 23.sp,
            width: MediaQuery.of(context).size.longestSide,
            // decoration: BoxDecoration(
            //   border: BorderDirectional(
            //     bottom: BorderSide(width: 1, color: Colors.grey),
            //   ),
            // ),
            child: Assets.images.hourlyDotLogocropped
                .image(fit: BoxFit.fill)
                .withPadding(padding: EdgeInsets.all(07.sp)),
          ),
          07.sp.height,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 07.sp,
                children: [
                  ExpansionMenuForDeskTop(
                    title: "Dashboard",
                    iconData: Icons.dashboard,
                    initialexpanded: dashboard ?? false,
                    menuwidget: [
                      InkWell(
                        onTap: () {
                          log("message");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                          );
                        },
                        child: Material(
                          color: Colors.transparent,
                          child: MenuCardsForDesktop(
                            color: Colors.black,
                            title: "Dashboard",
                            enable: dashboard ?? false,
                            icondata: Icons.dashboard,
                            pageIndex: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ExpansionMenuForDeskTop(
                    title: "Employee Management",
                    iconData: Icons.work,
                    initialexpanded: employeeManagement ?? false,
                    menuwidget: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmployeeManagement(),
                            ),
                          );
                        },

                        child: MenuCardsForDesktop(
                          color: Colors.black,
                          title: "All Employee",
                          enable: allEmployee ?? false,
                          icondata: Icons.group,
                          pageIndex: 0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddEmployeeData(),
                            ),
                          );
                        },

                        child: MenuCardsForDesktop(
                          color: Colors.black,
                          title: "Add Employee",
                          enable: addEmployee ?? false,
                          icondata: Icons.person_add,
                          pageIndex: 0,
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const EmployeeDetails(),
                      //       ),
                      //     );
                      //   },

                      //   child: MenuCardsForDesktop(
                      //     color: Colors.black,
                      //     title: "Employee Details",
                      //     enable: employeeDetails ?? false,
                      //     icondata: Icons.account_circle,
                      //     pageIndex: 0,
                      //   ),
                      // ),
                    ],
                  ),
                  ExpansionMenuForDeskTop(
                    title: "Hr Management",
                    iconData: Icons.account_balance_wallet,
                    initialexpanded: payrollManagement ?? false,
                    menuwidget: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const AttendanceManagement(),
                            ),
                          );
                        },

                        child: MenuCardsForDesktop(
                          color: Colors.black,
                          title: "Attendance Details",
                          enable: attendanceDetails ?? false,
                          icondata: Icons.event_available,
                          pageIndex: 0,
                        ),
                      ),
                    ],
                  ),
                  // ExpansionMenuForDeskTop(
                  //   title: "Report",
                  //   iconData: Icons.insert_drive_file,
                  //   initialexpanded: report ?? false,
                  //   menuwidget: [],
                  // ),
                  ExpansionMenuForDeskTop(
                    title: "Configuration",
                    iconData: Icons.insert_drive_file,
                    initialexpanded: configuration ?? false,
                    menuwidget: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConfiugrationPage(),
                            ),
                          );
                        },
                        child: MenuCardsForDesktop(
                          color: Colors.black,
                          title: "Configuration",
                          enable: configuration ?? false,
                          icondata: Icons.tune,
                          pageIndex: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ).withPadding(padding: EdgeInsets.symmetric(horizontal: 05.sp)),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  final IconData icon;
  const DashboardCard({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.sp,
      width: calcSize(context).longestSide,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(07.sp),
      ),
      child: AppText.small(title, fontSize: 11.sp),
    );
  }
}
