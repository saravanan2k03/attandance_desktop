import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConfigurationSetting extends StatelessWidget {
  const ConfigurationSetting({
    super.key,
    required this.punchInStartTimeController,
    required this.punchInEndTimeController,
    required this.punchInStartLateTimeController,
    required this.punchInEndLateTime,
    required this.punchOutStartTime,
    required this.punchOutEndTime,
    required this.overTimeWorkingEndTime,
  });

  final TextEditingController punchInStartTimeController;
  final TextEditingController punchInEndTimeController;
  final TextEditingController punchInStartLateTimeController;
  final TextEditingController punchInEndLateTime;
  final TextEditingController punchOutStartTime;
  final TextEditingController punchOutEndTime;
  final TextEditingController overTimeWorkingEndTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.sp,
      width: 60.sp,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: cardsColors,
        borderRadius: BorderRadius.circular(07.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                "Configuration Settings",
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),

              10.height, // spacing
              CustomBorderDropDownForm(
                hintText: "Work shift",
                dropDownMenu: workShift,
              ),
              10.height, // spacing
              CustomTextFormFieldwithcontroller(
                title: "Punch In Start Time",
                controller: punchInStartTimeController,
                readOnly: true,
                onTap: () async {
                  final selectedTime = await selectTime(context);
                  punchInStartTimeController.text = selectedTime;
                },
              ),

              10.height,

              CustomTextFormFieldwithcontroller(
                title: "Punch In End Time",
                controller: punchInEndTimeController,
                readOnly: true,
                onTap: () async {
                  final selectedTime = await selectTime(context);
                  punchInEndTimeController.text = selectedTime;
                },
              ),
              10.height,

              CustomTextFormFieldwithcontroller(
                title: "Punch In Start Late Time",
                controller: punchInStartLateTimeController,
                readOnly: true,
                onTap: () async {
                  final selectedTime = await selectTime(context);
                  punchInStartLateTimeController.text = selectedTime;
                },
              ),
              10.height,

              CustomTextFormFieldwithcontroller(
                title: "Punch In End Late Time",
                controller: punchInEndLateTime,
                readOnly: true,
                onTap: () async {
                  final selectedTime = await selectTime(context);
                  punchInEndLateTime.text = selectedTime;
                },
              ),
              10.height,

              CustomTextFormFieldwithcontroller(
                title: "Punch Out Start Time",
                controller: punchOutStartTime,
                readOnly: true,
                onTap: () async {
                  final selectedTime = await selectTime(context);
                  punchOutStartTime.text = selectedTime;
                },
              ),
              10.height,

              CustomTextFormFieldwithcontroller(
                title: "Punch Out End Time",
                controller: punchOutEndTime,
                readOnly: true,
                onTap: () async {
                  final selectedTime = await selectTime(context);
                  punchOutEndTime.text = selectedTime;
                },
              ),
              10.height,

              CustomTextFormFieldwithcontroller(
                title: "Over Time Working End Time",
                controller: overTimeWorkingEndTime,
                readOnly: true,
                onTap: () async {
                  final selectedTime = await selectTime(context);
                  overTimeWorkingEndTime.text = selectedTime;
                },
              ),
              10.height,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
