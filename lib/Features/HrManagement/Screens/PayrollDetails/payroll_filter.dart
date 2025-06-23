import 'package:act/Core/Constants/constant.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class LeaveRequestFilter extends StatelessWidget {
  const LeaveRequestFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fromDateController = TextEditingController();
    final TextEditingController toDateController = TextEditingController();
    return Wrap(
      spacing: 07.sp,
      runSpacing: 07.sp,
      children: [
        SizedBox(width: 40.sp, child: CustomBorderTextForm(title: "Search")),
        SizedBox(
          width: 40.sp,
          child: CustomTextFormFieldwithcontroller(
            title: "From",
            controller: fromDateController,
            readOnly: true,
            onTap: () {
              selectDate(context).then((value) {
                fromDateController.text = value;
              });
            },
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomTextFormFieldwithcontroller(
            title: "To",
            controller: toDateController,
            readOnly: true,
            onTap: () {
              selectDate(context).then((value) {
                toDateController.text = value;
              });
            },
          ),
        ),
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
