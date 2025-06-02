import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Screens/EmployeeLeaveRequest/leave_request_filter.dart';
import 'package:act/Features/EmployeeManagement/Screens/EmployeeLeaveRequest/remaning_leave_details.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeLeaveRequest extends StatelessWidget {
  const EmployeeLeaveRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        // spacing: 07.sp,
        children: [
          const LeaveRequestFilter(),
          10.height,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: commonColor,
                      borderRadius: BorderRadius.circular(05.sp),
                    ),
                    child: const Column(
                      children: [
                        CustomTable(
                          datacolumns: [
                            'ID',
                            'DATE',
                            'LEAVE CATEGORY',
                            'STATUS',
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(),
                const RemaningLeaveDetails(),
              ],
            ),
          ),
        ],
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}
