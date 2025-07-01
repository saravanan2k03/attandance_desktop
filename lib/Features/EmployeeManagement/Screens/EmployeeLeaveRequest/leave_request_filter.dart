import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LeaveRequestFilter extends StatelessWidget {
  const LeaveRequestFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(
                child: AppText.small(
                  "Leave Request",
                  fontSize: 11.sp,
                ).withPadding(padding: EdgeInsets.all(10.sp)),
              ),
            ),
          ],
        ).withPadding(padding: EdgeInsets.symmetric(vertical: 07.sp)),
        Container(
          width: calcSize(context).longestSide,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(05.sp)),
          child: Wrap(
            spacing: 07.sp,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              SizedBox(
                width: 40.sp,
                child: CustomBorderTextForm(title: "From"),
              ),
              SizedBox(width: 40.sp, child: CustomBorderTextForm(title: "To")),
              SizedBox(
                width: 40.sp,
                child: CustomBorderDropDownForm(hintText: "Category"),
              ),
              Container(
                height: 50,
                width: 35.sp,
                decoration: BoxDecoration(
                  color: commonColor,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(child: AppText.small("Search", fontSize: 11.sp)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
