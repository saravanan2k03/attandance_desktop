import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/HrManagement/Screens/PayrollDetails/payroll_filter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LeaveRequestCard extends StatelessWidget {
  const LeaveRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LeaveRequestFilter(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: commonColor,
                borderRadius: BorderRadius.circular(05.sp),
              ),
              child: const Column(
                children: [
                  CustomTable(datacolumns: ['Id', 'Status', "Time"]),
                ],
              ),
            ),
          ),
          07.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 17.sp,
                width: 30.sp,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(child: AppText.small("Prev", fontSize: 11.sp)),
              ),
              10.width,
              Container(
                height: 17.sp,
                width: 30.sp,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(child: AppText.small("Next", fontSize: 11.sp)),
              ),
            ],
          ),
        ],
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}
