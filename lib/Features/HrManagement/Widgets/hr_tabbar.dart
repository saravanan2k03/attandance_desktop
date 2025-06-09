import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HrTabbar extends StatelessWidget {
  const HrTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: cardsColors,
            borderRadius: BorderRadius.circular(07.sp),
          ),
          child: const Row(
            // spacing: 07.sp,
            children: [
              TabbarCard(cardenable: true, label: "Attendance Details"),
              TabbarCard(cardenable: false, label: "Payroll Details"),
              TabbarCard(cardenable: false, label: "Leave Request Approval"),
            ],
          ).withPadding(padding: EdgeInsets.all(07.sp)),
        ).withPadding(padding: EdgeInsets.all(07.sp)),
      ],
    );
  }
}
