import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({super.key});

  @override
  State<EmployeeManagement> createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement> {
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
                          width: calcSize(context).longestSide,
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
                                  AppText.small("All Employee", fontSize: 18),
                                ],
                              ),
                              AppText.medium("All Employee", fontSize: 18),
                              07.sp.width,
                            ],
                          ),
                        ),
                        15.height,
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 50.sp,
                                  child: CustomBorderTextForm(title: "Search"),
                                ),
                                10.height,
                                const CustomTable(
                                  datacolumns: [
                                    'Name',
                                    'Email Id',
                                    'Department',
                                    'Designation',
                                    'Gender',
                                    'Work Shift',
                                  ],
                                ),
                                10.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 17.sp,
                                      width: 30.sp,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(
                                          07.sp,
                                        ),
                                      ),
                                      child: Center(
                                        child: AppText.small(
                                          "Prev",
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ),
                                    10.width,
                                    Container(
                                      height: 17.sp,
                                      width: 30.sp,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(
                                          07.sp,
                                        ),
                                      ),
                                      child: Center(
                                        child: AppText.small(
                                          "Next",
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ).withPadding(padding: EdgeInsets.all(10.sp)),
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
