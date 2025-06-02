import 'package:act/Core/Constants/constant.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RemaningLeaveDetails extends StatelessWidget {
  const RemaningLeaveDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: commonColor,
          borderRadius: BorderRadius.circular(05.sp),
        ),
        child: const Column(
          children: [
            CustomTable(datacolumns: ['LEAVE CATEGORY', 'COUNT']),
          ],
        ),
      ),
    );
  }
}
