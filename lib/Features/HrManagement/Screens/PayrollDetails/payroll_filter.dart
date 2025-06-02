import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class PayrollFilter extends StatelessWidget {
  const PayrollFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 07.sp,
      runSpacing: 07.sp,
      children: [
        SizedBox(width: 40.sp, child: CustomBorderTextForm(title: "Search")),
        SizedBox(width: 40.sp, child: CustomBorderTextForm(title: "From")),
        SizedBox(width: 40.sp, child: CustomBorderTextForm(title: "To")),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(hintText: "Work shift"),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(hintText: "Category"),
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
    ).withPadding(padding: EdgeInsets.all(07.sp));
  }
}
