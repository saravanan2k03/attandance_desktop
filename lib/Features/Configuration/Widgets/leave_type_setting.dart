import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LeaveTypeSetting extends StatelessWidget {
  const LeaveTypeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.sp,
      width: 60.sp,
      decoration: BoxDecoration(color: cardsColors),
      child: Column(
        children: [
          AppText.medium(
            "Leave Type Setting",
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          07.sp.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomBorderTextForm(title: "Leave type"),
              07.sp.width,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close),
                  ),
                  07.width,
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.check),
                  ),
                ],
              ),
            ],
          ),
          07.height,
          Expanded(
            child: Container(
              color: commonColor,
              child: Column(
                children: [
                  const CustomTable(
                    datacolumns: ['ID', 'Leave Type', 'Active'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}
