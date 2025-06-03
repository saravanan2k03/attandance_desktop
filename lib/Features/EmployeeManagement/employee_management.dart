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
          Expanded(
            flex: 2,
            child: CustomDrawer(employeeManagement: true, allEmployee: true),
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
                                AllEmployeeFilter().withPadding(
                                  padding: EdgeInsets.all(07.sp),
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
                                    'Date of Joining',
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

class AllEmployeeFilter extends StatelessWidget {
  const AllEmployeeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 07.sp,
      runSpacing: 07.sp,
      children: [
        SizedBox(width: 40.sp, child: CustomBorderTextForm(title: "Search")),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(hintText: "Gender"),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(hintText: "Department"),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(hintText: "Designation"),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(hintText: "Work shift"),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 18.sp,
              width: 40.sp,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(child: AppText.small("Clear", fontSize: 17)),
            ),
            07.width,
            Container(
              height: 18.sp,
              width: 40.sp,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(child: AppText.small("Submit", fontSize: 17)),
            ),
          ],
        ),
      ],
    );
  }
}
